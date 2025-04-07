Ruby version: 3.4.2
Rails version: 8.0.2

Salve!

Prima di testare il programma effettuare queste configurazioni extra:

1) Generare un file ".env" per la gestione delle variabili d'ambiente. All'interno del file configurare le seguenti variabili d'ambiente

GOOGLE_CLIENT_ID
GOOGLE_CLIENT_SECRET
GOOGLE_API_KEY
CARD_ENCRYPTION_KEY

I primi due sono per la gestione dell'accesso con google,la api key per abilitare i servizi API che abbiamo implementato da Google Cloud Console Platform, card_encryption_key è la chiave di criptazione che viene utilizzata per criptare i dati della carta di credito composta da 32 caratteri generabile tramite rails secret (Assicurarsi che non venga generata da 64 caratteri). Le variabili d'ambiente vengono gestiti dalla gemma 

gem 'dotenv-rails', groups: [:development, :test]


API abilitate da Google Cloud Console:
    • Identity Toolkit API
    • Google+ API
    • Maps Embed API

2) Assicurarsi che le impostazioni di PostgreSQL siano funzionali, andare a modificare il file config/database.yml

3) Generare il database e popolarlo:
- Per la generazione:
    Rails db:create db:migrate
- Per la popolazione del server, andare su rails console e importare i seguenti record:

attrazioni, strutture, destinazione:

Attraction.create(name:"Colosseo", city:"Roma", country:"Italia", season:"tutte",bus:true, plane:true, train:true, ship:false)

Attraction.create(name:"Sagrada Familia", city:"Barcellona", country:"Spagna", season:"tutte",bus:true, plane:true, train:true, ship:false)

Attraction.create(name:"Louvre", city:"Parigi", country:"Francia", season:"tutte",bus:true, plane:true, train:true, ship:false)

Attraction.create(name:"Statua della Libertà", city:"New York", country:"USA", season:"tutte",bus:true, plane:true, train:true, ship:false)

Attraction.create(name:"Fiordi", city:"Bergen", country:"Norvegia", season:"estate",bus:false, plane:false, train:false, ship:true)

Stay.create(name:"La Tana di Bilbo Beggins", city:"Bergen", country:"Norvegia", family:true, job:false, group:true, bus:true, train:false, price:119.99, stay_type:"Appartamento")

Stay.create(name:"Hotel Fleming", city:"Roma", country:"Italia", family:false, job:true, group:false, bus:true, train:false, price:139.99, stay_type:"Hotel")

Stay.create(name:"Hotel Concordia", city:"Barcellona", country:"Spagna", family:true, job:true, group:true, bus:true, train:false, price:99.99, stay_type:"Hotel")

Stay.create(name:"Maison La Boheme", city:"Parigi", country:"Francia", family:true, job:true, group:true, bus:true, train:true, price:109.99, stay_type:"Appartamento")

Stay.create(name:"American Dream", city:"New York", country:"USA", family:true, job:true, group:true, bus:true, train:false, price:49.99, stay_type:"Ostello")

Destination.create(name:"Roma", country:"Italia", plane:true, train:true, ship:false)

Destination.create(name:"Barcellona", country:"Spagna", plane:true, train:true, ship:false)

Destination.create(name:"Parigi", country:"Francia", plane:true, train:true, ship:false)

Destination.create(name:"New York", country:"USA", plane:true, train:true, ship:false)

Destination.create(name:"Bergen", country:"Norvegia", plane:true, train:true, ship:false)
