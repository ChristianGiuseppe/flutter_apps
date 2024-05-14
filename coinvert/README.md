# coinvert

Coinvert app di conversione di valute ("Coin Convert App") è un'applicazione mobile che permette agli utenti di convertire valute da una all'altra in tempo reale utilizzando i tassi di cambio correnti. Questo tipo di applicazione è estremamente utile per viaggiatori, investitori, professionisti finanziari e chiunque abbia a che fare con transazioni in diverse valute.

## Struttura del Progetto

Il progetto è organizzato seguendo una struttura delle cartelle ben definita per garantire una gestione efficiente del codice sorgente. Di seguito è riportata una panoramica delle principali cartelle:

- **lib/**: Contiene tutto il codice sorgente dell'applicazione.
  - **data/**: Contiene i componenti per la gestione dei dati.
    - **core/**: Classi fondamentali per la gestione dei dati.
    - **datasources/**: Implementazioni dei sorgenti dati.
    - **repository/**: Implementazioni dei repository.
  - **presentation/**: Contiene i componenti per la presentazione dell'interfaccia utente.
    - **screens/**: Schermate dell'applicazione.
    - **widgets/**: Widget riutilizzabili.
    - **viewmodels/**: Contiene i ViewModel per la gestione della logica di business.
  - **config/**: File di configurazione per l'avvio dell'applicazione.
  - **tests/**: Contiene i test unitari e di integrazione.

## Setup e Installazione

Per avviare l'applicazione, seguire i seguenti passaggi:

1. Accedere alla cartella del progetto: `cd [coinvert]`
2. Installare le dipendenze: `flutter pub get`
3. Eseguire l'applicazione: `flutter run`

### Configurazioni per VS Code e Android Studio

Se si utilizza Visual Studio Code come ambiente di sviluppo, è possibile utilizzare le seguenti configurazioni:
- **Registrazione per la Key** https://www.exchangerate-api.com
- **Dev**: configurazioni di dev
- **Prod**: configurazione di prod

Se si utilizzano Visual Studio Code e Android Studio come ambienti di sviluppo, è possibile utilizzare le seguenti configurazioni:

- **Flutter (versione 3.19.2)**: Assicurarsi di utilizzare la versione 3.19.2 o successiva per beneficiare delle ultime correzioni di bug e delle nuove funzionalità.

- **VS Code (versione 1.88.1)**: VS Code è un ambiente di sviluppo leggero e potente con numerose estensioni per il supporto di Flutter e Dart.

- **Android Studio (versione 2023.1)**: Android Studio è un ambiente di sviluppo integrato (IDE) ufficiale per lo sviluppo di app Android. È possibile utilizzarlo per sviluppare, debuggare e testare le app Flutter sia per Android che per iOS.

## State Management con Provider

Nel progetto Coinvert, lo state management è gestito utilizzando il pacchetto Provider, che offre un modo semplice ed efficiente per gestire lo stato dell'applicazione e condividere i dati tra i widget.

Il pacchetto Provider consente di definire e utilizzare facilmente modelli di stato (ViewModel) per gestire la logica di business dell'applicazione. Questo approccio favorisce una separazione chiara tra la presentazione e la logica di business, migliorando la manutenibilità e la scalabilità del codice.
