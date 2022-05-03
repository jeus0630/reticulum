mix local.hex --force && mix local.rebar --force && mix deps.get &&\
mix deps.clean mime --build && rm -rf _build && mix compile &&\
MIX_ENV=turkey mix distillery.release &&\
cp -r ./_build/turkey/rel/ret ../ &&\
cd ../ret &&\
openssl req -x509 -newkey rsa:2048 -sha256 -days 36500 -nodes -keyout key.pem -out cert.pem -subj '/CN=ret' && cp cert.pem cacert.pem
