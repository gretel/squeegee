if exist e:\cert\VBoxCertUtil (
   cmd /c e:\cert\VBoxCertUtil add-trusted-publisher e:\cert\oracle-vbox.cer --root e:\cert\oracle-vbox.cer
) else (
   cmd /c certutil -addstore -f "TrustedPublisher" a:oracle-cert.cer
)
cmd /c e:\VBoxWindowsAdditions-amd64.exe /S

EXIT 0
