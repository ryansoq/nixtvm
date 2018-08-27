. /etc/profile

if test -z "$https_proxy" ; then
  echo "http_proxy and https_proxy should be set via docker build-args or by ENV" >&2
  exit 1
fi

cacerts=/usr/local/share/ca-certificates/Huawei.crt

#{{{
cat >$cacerts <<EOF
-----BEGIN CERTIFICATE-----
MIICjDCCAjagAwIBAgIQYX5k+7Hpv5NBWIbUDYLKszANBgkqhkiG9w0BAQUFADCB
ijEiMCAGCSqGSIb3DQEJARYTZmFuZnV5b3VAaHVhd2VpLmNvbTELMAkGA1UEBhMC
Q04xEjAQBgNVBAgTCWd1YW5nZG9uZzESMBAGA1UEBxMJc2hlbmd6aGVuMQ8wDQYD
VQQKEwZodWF3ZWkxCzAJBgNVBAsTAklUMREwDwYDVQQDEwhodWF3ZWljYTAeFw0w
MjA0MDIwODAyNTdaFw0yMTA1MTAxMjM3NTVaMIGKMSIwIAYJKoZIhvcNAQkBFhNm
YW5mdXlvdUBodWF3ZWkuY29tMQswCQYDVQQGEwJDTjESMBAGA1UECBMJZ3Vhbmdk
b25nMRIwEAYDVQQHEwlzaGVuZ3poZW4xDzANBgNVBAoTBmh1YXdlaTELMAkGA1UE
CxMCSVQxETAPBgNVBAMTCGh1YXdlaWNhMFwwDQYJKoZIhvcNAQEBBQADSwAwSAJB
AKSinEkdOOEsu8f/261v1ogFIyS2E78y9GXDaPRk8vP3vZD0Asazb9a66Enz5s5A
HPGkFEL+YhmqmgmEp2l0AacCAwEAAaN2MHQwCwYDVR0PBAQDAgHGMA8GA1UdEwEB
/wQFMAMBAf8wHQYDVR0OBBYEFAmXH9sGzz0pfzZ0FMflj9AIGO2kMBAGCSsGAQQB
gjcVAQQDAgEBMCMGCSsGAQQBgjcVAgQWBBRuO+h/kFMFLtlnFc4a8gX4jNPgaTAN
BgkqhkiG9w0BAQUFAANBAHP5YuAAYGpoCOCNMs1zFfr2MJBZOrq8JtV0yE5Y+A4K
928Xr9D+gnSi4w4XgOPEq/FL8S7AQ10ykcYQkpwkhr8=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDjjCCAnagAwIBAgIQXPhhughdNbVAcP0HrzXfaTANBgkqhkiG9w0BAQUFADAh
MR8wHQYDVQQDExZIdWF3ZWkgSVQgTWluaSBSb290IENBMB4XDTE0MDYyODA5MzY1
MVoXDTI0MDYyODA5NDY0M1owITEfMB0GA1UEAxMWSHVhd2VpIElUIE1pbmkgUm9v
dCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMmnJXWPHBdtMnKh
EklIX1JQg0bK80afXvfTrHI4N1NRY5ocGey5lr27QMi21C79izK19j2ivUiDemBE
yYHpKVpDcplpzmByT1DgHbHAngax8uRrKU6H9dYPb7D5jrSnrE2VQ2r1VATnE3Js
v3kLo2oiT2+mLiyfPgJdd6SqngfWsBLGQboav2d+Dl5uKWSyBM9pNm9CRS9MQE+u
gCRQZHfqlddHRV/629jj6tCBvKWxq31ag+4PXYCwZwErbCV1Z5mFFLcKdrGI0PQZ
9SGQXo7FpjW+RZbyquV1nPGQSUbgi5+KcJMqWZIeGXK+q4s+AYUCcBZKvfslbr0X
u/PO4PMCAwEAAaOBwTCBvjALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAd
BgNVHQ4EFgQUlZc5wrkq127aG8Q3bC/A1OZ+G0UwEAYJKwYBBAGCNxUBBAMCAQAw
bQYDVR0gBGYwZDBiBgRVHSAAMFowWAYIKwYBBQUHAgIwTB5KAGgAdAB0AHAAOgAv
AC8AaAB3AGkAdABwAGsAaQAuAGgAdQBhAHcAZQBpAC4AYwBvAG0ALwBjAHAAcwAv
AGMAcABzAC4AcABkAGYwDQYJKoZIhvcNAQEFBQADggEBAEXakJti7NEI7nsZtLJ8
v7Kxw0Xc/q/rgWbjRB95XjEhe85UCwXQjy5aQHP6ctmEaGhv6pwaKt72WBv2/slM
tZS/PArFFcOIHFeb6u0/GWcdpqtw9isXG9Ij8vGQolFDz97gdoEKV7VLo4E5tZQu
byOu5xY9wO7sQHwf9OmtCliWvYIEYpIFuCNxVpkCfx5P+BtF89f4RuU7Wgd/KHWe
rArOe2ar7lERvYZXVlBEXcj5ui40Xk7Qqe0M58RE+rtpeObzHwHFPPFookN+Nzho
rZvULZa9eJoVH36VF9x1/50dcngC9ZFkHSbvwWXBJH9ZMl8zTSryWiECd5GrLrrC
OiM=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFrDCCA5SgAwIBAgIQMvvk+dsqBptBSeXEBBFiRjANBgkqhkiG9w0BAQsFADAw
MRIwEAYDVQQKEwlIdWF3ZWkgSVQxGjAYBgNVBAMTEUh1YXdlaSBJVCBSb290IENB
MB4XDTEzMDkyOTA2NTI0NFoXDTQ1MDkyOTA3MDIyNlowMDESMBAGA1UEChMJSHVh
d2VpIElUMRowGAYDVQQDExFIdWF3ZWkgSVQgUm9vdCBDQTCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBAKCa/7dGb1qmhYyDSwxekqVUcKRaAJWi3n65E9KD
5hYb6oZkCaTUTwX+/m6oT5tj/TLow99Zwm/xcZ4e1xh2inqkWDPKdRRuiAtJLu8T
JoGl0Dlql2vhQvZPIAZOis8+j4sKZrFPNUjVp18KH0Dpgiu/oLlRjAh0+naMp75E
/PAxAmPKW9qNAY60QTG2JzyoqSj6G40ss4cx5JouCCaqdvFSKFf3qSbFdMk0o8az
w3ESmo4vt2SmwN4NC5XJ5sGVTG5yRnqdVgwvC6sgodclrDuAFXpSrMW4LZlVT9yA
PXMaZFrjrzi7cPSkLxhhE0shwv+nvvaM1k/83naL3675DTNfeni7Hw1lctfs0Lu9
o+P8A/BrlbGrWXfl7V16w5fsOkB/vY9n9H8Wvoj2jChOolxbb1Xu9Lzlm+L9I/4H
Vc8oFlIdfapZ/Y3pL+sqsPHRazpz114t9wDKkjCgileEm+LEHmqbA+9fioeSxYzT
PDeP9M0P3BV05/MVBgv5xP1xNrCZwRAejcsrewty2pCRbVfAZS8aQ5u7QxWRl3Ow
OryZxWzt/KCO+IUmtQ6VHN5kEawrYBns44XCyZ9lOZWEBsuKr2spAMSZt/ZD2Bny
KiHZLrcJlOlV8lZTEJknPj7Nux/hkHd7yhlrWF4UQPRJkmlcy2XOEurzWk3wKtHP
d44pAgMBAAGjgcEwgb4wCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHQYD
VR0OBBYEFNpkGmV7FNjwnRjj8612vZMEWkqNMBAGCSsGAQQBgjcVAQQDAgEAMG0G
A1UdIARmMGQwYgYEVR0gADBaMFgGCCsGAQUFBwICMEweSgBoAHQAdABwADoALwAv
AGgAdwBpAHQAcABrAGkALgBoAHUAYQB3AGUAaQAuAGMAbwBtAC8AYwBwAHMALwBj
AHAAcwAuAHAAZABmMA0GCSqGSIb3DQEBCwUAA4ICAQCN/UHKuI4FQV8O5HJ7yr/I
sfPo4v9aKpyAVbYPZur3+tR4IrQ19LjmAdczQm0f4lVIEwAxK7v8tTuBq36//qtf
VG5H7OmDYDdatAHgrqQwxMmbzN5+mbpO+aSf/5a03BS5lweEFTBXvqCtGvKJb4N+
umyNpxBYT/2JkauLmvk/NPbU8JLRPnmjRlXsMHB/vXY2BB8OIn0AnGdq8DS4HAm9
/o4DU818pBXHIWgkkgsfOCRU3UeoZ1JufmXvvxrM78LLWhilHpyZR6/lR/PV0Bjd
7wipRd8jBkQFIZ2X4ZFodM1NDtKg4mroajp2SCDUeE1R2HcNpkz5lcgarSLf30V7
zPENdV3yb2vk1BGRIqBxcxqt36L7XnUZPBGmHDqX3j6jIVWvw0e0Pdzv+pftBwGr
8GavQUryUAXrcHxjdQgQMp82CmORrhLsJ79rpYRQcxV/Iglpzxsbg5GOrkiA2o2/
5dGf2hfOYnP3T93TdM7DsoinEMBursJkeo5sQBeVE+kFNYhqJ+12QNvhdigqa96Y
b0h7dFqZxebJFEIUVUfx6BJNmlz/Ax/USWIwWTmelJk4Mo7mAM6qgApEN+wFG63t
Sk94Y1naBA9ey4wyfwPTSqNJ2LFy7SCiUJTTVxWd6/T49ScjIevTZSuMezjqcB4b
7THUftXuufrVtAQ7iSP3IQ==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDtjCCAp6gAwIBAgIBATANBgkqhkiG9w0BAQUFADCBjjEmMCQGA1UECgwdSHVh
d2VpIFRlY2hub2xvZ2llcyBDby4sIEx0ZC4xCzAJBgNVBAsMAklUMSAwHgYDVQQH
DBdIdWF3ZWkgSW50ZXJuYWwgTmV0d29yazELMAkGA1UEBhMCQ04xKDAmBgNVBAMM
H0h1YXdlaSBTZWN1cmUgSW50ZXJuZXQgUHJveHkgQ0EwHhcNMTAxMjI5MDIxMTU5
WhcNMjAxMjI5MDIxMTU5WjCBjjEmMCQGA1UECgwdSHVhd2VpIFRlY2hub2xvZ2ll
cyBDby4sIEx0ZC4xCzAJBgNVBAsMAklUMSAwHgYDVQQHDBdIdWF3ZWkgSW50ZXJu
YWwgTmV0d29yazELMAkGA1UEBhMCQ04xKDAmBgNVBAMMH0h1YXdlaSBTZWN1cmUg
SW50ZXJuZXQgUHJveHkgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQCI/egcF6Rk8A9oGpFT6uCPyE2E+P30Dgt6rc25twLk3qP6CrHS0Nc5GW+YCjO1
swFMUqNNnMKPgMxlbagTzvlkfCdh7TV2gkkEsWosW93DcqXO1Ee//PkWikUxS7hD
5PNufqoh67IhtpC2ipjfnmSFIBw1flNLGJGb5VvnWoBXFBCobyti0D6VsLxyhzm9
MDXj39s5C3nSyoVFDiW2b5XgR7H8wcIXksIJXa1Ur6xc8RG7he1S232r+htbhfks
VEeiNgrp+h+dTpd4/NEaNIWj5T/WopE5pC0YZHq0PIG2LZhWsd4VHJST8ke3RrXi
nnEoKTYrz32677uiXfoplhD3AgMBAAGjHTAbMAwGA1UdEwQFMAMBAf8wCwYDVR0P
BAQDAgEGMA0GCSqGSIb3DQEBBQUAA4IBAQCGmMTqx2rhuBAK1Qgn8VLSKOwFum0W
sM/er+OZV6dtrUxtCWT+ddFiCiNnRnogw2MIEez22Ki2gnwJFuxV2fBNUFWz9RT2
i6lsXwv1B+/FjDzojmOrTOXG8bkyLsamGtPDr/lJNTMoRoXaLUWy/SclbSYXyccg
mk7Dva92d4+2yvncsgZaUueCZg0BsCG3wwiXFiHblT42nLfqb7P4ZkILq2YsppT2
nOdPwr4BN5NxcVLji2ftl2q1vu2Ih7NFI61adb+fs8/xW6EsgkGwMYquc87D9tzk
o5TW63xgZeVFtbhc3lJgX4WwzvNW0DMpF9aiHNJhzwl0E1ULGP/fPahq
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIID2TCCAsGgAwIBAgIJALQPO9XxFFZmMA0GCSqGSIb3DQEBCwUAMIGCMQswCQYD
VQQGEwJjbjESMBAGA1UECAwJR3VhbmdEb25nMREwDwYDVQQHDAhTaGVuemhlbjEP
MA0GA1UECgwGSHVhd2VpMQswCQYDVQQLDAJJVDEuMCwGA1UEAwwlSHVhd2VpIFdl
YiBTZWN1cmUgSW50ZXJuZXQgR2F0ZXdheSBDQTAeFw0xNjA1MTAwOTAyMjdaFw0y
NjA1MDgwOTAyMjdaMIGCMQswCQYDVQQGEwJjbjESMBAGA1UECAwJR3VhbmdEb25n
MREwDwYDVQQHDAhTaGVuemhlbjEPMA0GA1UECgwGSHVhd2VpMQswCQYDVQQLDAJJ
VDEuMCwGA1UEAwwlSHVhd2VpIFdlYiBTZWN1cmUgSW50ZXJuZXQgR2F0ZXdheSBD
QTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANk9kMn2ivB+6Lp23PIX
OaQ3Z7YfXvBH5HfecFOo18b9jC1DhZ3v5URScjzkg8bb616WS00E9oVyvcaGXuL4
Q0ztCwOszF0YwcQlnoLBpAqq6v5kJgXLvGfjx+FKVjFcHVVlVJeJviPgGm4/2FLh
odoreBqPRAfLRuSJ5U+VvgYipKMswTXh7fAK/2LkTf1dpWNvRsoXVm692uFkGuNx
dCdUHYCI5rl6TqMXht/ZINiclroQLkd0gJKhDVmnygEjwAJMMiJ5Z+Tltc6WZoMD
lrjETdpkY6e/qPhzutxDJv5XH9nXN33Eu9VgE1fVEFUGequcFXX7LXSHE1lzFeae
rG0CAwEAAaNQME4wHQYDVR0OBBYEFDB6DZZX4Am+isCoa48e4ZdrAXpsMB8GA1Ud
IwQYMBaAFDB6DZZX4Am+isCoa48e4ZdrAXpsMAwGA1UdEwQFMAMBAf8wDQYJKoZI
hvcNAQELBQADggEBAKN9kSjRX56yw2Ku5Mm3gZu/kQQw+mLkIuJEeDwS6LWjW0Hv
3l3xlv/Uxw4hQmo6OXqQ2OM4dfIJoVYKqiLlBCpXvO/X600rq3UPediEMaXkmM+F
tuJnoPCXmew7QvvQQvwis+0xmhpRPg0N6xIK01vIbAV69TkpwJW3dujlFuRJgSvn
rRab4gVi14x+bUgTb6HCvDH99PhADvXOuI1mk6Kb/JhCNbhRAHezyfLrvimxI0Ky
2KZWitN+M1UWvSYG8jmtDm+/FuA93V1yErRjKj92egCgMlu67lliddt7zzzzqW+U
QLU0ewUmUHQsV5mk62v1e8sRViHBlB2HJ3DU5gE=
-----END CERTIFICATE-----
EOF
# }}}

update-ca-certificates

if test -d "$JAVA_HOME" ; then

  keystore=$JAVA_HOME/lib/security/cacerts
  pems_dir=/tmp/pems
  rm -rf "$pems_dir" 2>/dev/null || true
  mkdir "$pems_dir"
  (
  cd "$pems_dir"
  awk 'BEGIN {c=0;doPrint=0;} /END CERT/ {print > "cert." c ".pem";doPrint=0;} /BEGIN CERT/{c++;doPrint=1;} { if(doPrint == 1) {print > "cert." c ".pem"} }' < $cacerts
  for f in `ls cert.*.pem`; do
    keytool -import -trustcacerts -noprompt -keystore "$keystore" -alias "`basename $f`" -file "$f" -storepass changeit;
  done
  )
  rm -rf "$pems_dir"
else
  echo "JAVA_HOME is not set" >&2
fi

PROXY_HOST=`echo $https_proxy | sed 's@.*//\(.*\):.*@\1@'`
PROXY_PORT=`echo $https_proxy | sed 's@.*//.*:\(.*\)@\1@'`
{
echo "export http_proxy=$http_proxy"
echo "export https_proxy=$https_proxy"
echo "export HTTP_PROXY=$http_proxy"
echo "export HTTPS_PROXY=$https_proxy"
echo "export GRADLE_OPTS='-Dorg.gradle.daemon=false -Dandroid.builder.sdkDownload=true -Dorg.gradle.jvmargs=-Xmx2048M -Dhttp.proxyHost=$PROXY_HOST -Dhttp.proxyPort=$PROXY_PORT -Dhttps.proxyHost=$PROXY_HOST -Dhttps.proxyPort=$PROXY_PORT'"
echo "export MAVEN_OPTS='-Dhttps.proxyHost=$PROXY_HOST -Dhttps.proxyPort=$PROXY_PORT -Dmaven.wagon.http.ssl.insecure=true'"
} >>/etc/profile

echo ca_certificate=/etc/ssl/certs/ca-certificates.crt >> /etc/wgetrc

mkdir /root/.android/
cat >/root/.android/androidtool.cfg <<EOF
http.proxyHost=$PROXY_HOST
http.proxyPort=$PROXY_PORT
https.proxyHost=$PROXY_HOST
https.proxyPort=$PROXY_PORT
EOF

