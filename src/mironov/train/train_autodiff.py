import tvm
import topi
import numpy as np
from nnvm.testing.check_computation import check_numerical_grads
import time

import keras.datasets.mnist as mnist

def minst_load():
  (X,y),(Xte,yte) = mnist.load_data("/tmp/mnist.npz")
  return (X,y),(Xte,yte)


def get_shape(tensor):
  return [tvm.ir_pass.Simplify(s).value for s in tensor.shape]


def conv_run(out, inp, args=[], in_range=(-10,10)):
  sout = tvm.create_schedule(out.op)
  mout = tvm.build(sout, [out] + inp + args)

  ones = topi.full_like(out, 1.0)

  t = time.time()
  jacs = list(tvm.ir_pass.JacobianRecursive(out, inp, ones))
  print("JAC TIME: ", time.time() - t)

  t = time.time()
  sjac = tvm.create_schedule([j.op for j in jacs])
  mjac = tvm.build(sjac, jacs + inp + args)
  print("BUILD TIME: ", time.time() - t)
  return mjac

def conv_build():
  batch_size = 1
  num_classes = 10

  features = 4
  dense_units = 16

  x = tvm.placeholder((batch_size, 28, 14, 1))
  y = tvm.placeholder((batch_size, num_classes))

  w1 = tvm.placeholder((features, 1, 3, 5))
  b1 = tvm.placeholder((features,))
  w2 = tvm.placeholder((features, features, 3, 5))
  b2 = tvm.placeholder((features,))
  b3 = tvm.placeholder((dense_units,))
  w4 = tvm.placeholder((num_classes, dense_units))
  b4 = tvm.placeholder((num_classes,))

  t = topi.transpose(x, [0, 3, 1, 2])
  t = topi.nn.relu(topi.nn.conv2d(t, w1, 1, 0) + topi.reshape(b1, (1, features, 1, 1)))
  t = topi.nn.relu(topi.nn.conv2d(t, w2, 1, 0) + topi.reshape(b2, (1, features, 1, 1)))
  t = topi.nn.pool(t, [2, 2], [2, 2], [0, 0, 0, 0], 'avg')
  t = topi.transpose(t, [0, 2, 3, 1])
  t = topi.nn.flatten(t)
  w3 = tvm.placeholder((dense_units, get_shape(t)[1]))
  t = topi.nn.relu(topi.nn.dense(t, w3, b3))
  t = topi.nn.dense(t, w4, b4)

  t = - topi.sum(y * topi.nn.log_softmax(t)) / batch_size

  weights = [w1, b1, w2, b2, w3, b3, w4, b4]

  return conv_run(t, weights, [x, y], in_range=(-1.0, 1.0))


def demo_ad():
  x = tvm.placeholder((1,))
  k = tvm.placeholder((1,))
  y = tvm.compute((1,), lambda i: x[i]*x[i]*k[0], name='y')

  [dy] = tvm.ir_pass.JacobianRecursive(y, [x], topi.full_like(y, 1.0))

  sdy = tvm.create_schedule(dy.op)
  mdy = tvm.build(sdy, [dy,x,k])

  dy_out = tvm.nd.empty(get_shape(y), tvm.float32)

  mdy(dy_out,tvm.nd.array(np.array([1.0]).astype(x.dtype))
            ,tvm.nd.array(np.array([4.0]).astype(k.dtype)))
  print(dy_out)


def ex2_build():
  npoints = 20
  x = tvm.placeholder((1,))
  k = tvm.placeholder((2,))
  y = tvm.compute((1,), lambda i: x[i]*x[i]*k[0] + x[i]*k[1], name='y')

  ones = topi.full_like(y, 1.0)
  [dy] = list(tvm.ir_pass.JacobianRecursive(y, [x], ones))
  # print('jac',type(jac),jac[0])

  sdy = tvm.create_schedule(dy.op)
  sy = tvm.create_schedule(y.op)

  my = tvm.build(sy, [y,x,k])
  mdy = tvm.build(sdy, [dy,x,k])

  xs=np.linspace(-10.0,10.0,20);ys=[];dys=[]
  for xi in xs:
    k_in = tvm.nd.array(np.array([4.0, 2.0]).astype(k.dtype))

    y_out = tvm.nd.empty(get_shape(y), y.dtype)
    my(y_out, tvm.nd.array(np.array([xi]).astype(x.dtype)), k_in)
    ys.append(y_out.asnumpy())

    dy_out = tvm.nd.empty(get_shape(y), dy.dtype)
    mdy(dy_out, tvm.nd.array(np.array([xi]).astype(x.dtype)), k_in)
    dys.append(dy_out.asnumpy())

    # print(xi, y_out.asnumpy(), dy_out.asnumpy())

  print(xs,ys,dys)


