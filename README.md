# Pametni ugovor za glasanje

## Opis

Kreiran je pametni ugovor koji omogućava učesnicima da glasaju.

Pre otpremanja, neophodno je definisati opcije tj. kandidate.
Za njih se čuvaju ime i broj glasova.

Ugovor vodi računa o listi kandidata.
Takođe vodi evidenciju učesnika koji su već glasali.
Može da pruži informaciju o trenutnom vodećem kandidatu.

Najvažnije, ugovor pruža mogućnost učesnicima da glasaju.
Integritet sistema se zadržava proverom da li kandidat za koga se glasa
postoji, kao i da li je učesnik već glasao. 

## Tehnologije

Pametni ugovor je napisan u programskom jeziku *Solidity*.
Reprezentovan je jednim fajlom sa ekstenzijom `.sol`.

Za testiranje, korišćen je [Remix IDE](https://app.remix.live) na internetu.
Tu je uvezen kod sa ovog Github repozitorijuma.
Nakon kompajliranja izvornog koda, ode se do sekcije *Deploy*,
gde je moguće simulirati izvršenje pametnog ugovora pomoću virtuelne mašine.
