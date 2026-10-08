# 🌻 Per Sandy

Una piccola pagina web romantica, pensata per essere aperta dal telefono: un viaggio fra foto e video, con animazioni delicate, un'atmosfera da "ora d'oro" e un finale a sorpresa.

Sito statico (HTML, CSS e JavaScript in un unico file), pubblicato con **GitHub Pages**.

---

## Struttura del progetto

```
.
├── index.html            # il sito (pagina unica)
├── README.md
├── .gitignore
├── assets/
│   ├── photos/           # foto (.jpg)
│   └── videos/           # video (.mp4, H.264)
└── tools/
    └── comprimi-video.sh # riduce il peso dei video per il web
```

Convenzioni sui file:

- nomi **tutti minuscoli**, senza spazi, con il trattino basso (`prima_alba.jpg`);
- foto in `.jpg`, video in `.mp4` (codec H.264): GitHub Pages distingue maiuscole e minuscole, quindi `Foto.JPG` e `foto.jpg` sono due file diversi.

## Tecnologie

- HTML, CSS e JavaScript vanilla, nessuna dipendenza da installare
- Font: Playfair Display, Great Vibes e Jost (Google Fonts)
- Hosting: GitHub Pages

## Modificare i contenuti

I ricordi sono definiti nella lista `MEMORIES`, all'inizio dello `<script>` in `index.html`. Ogni voce ha un file (foto o video), una didascalia, un titolo e un testo:

```js
{ img:'torneo.jpg', alt:'Dopo il torneo', cap:'dopo il torneo', h:'Titolo', p:'Testo del ricordo.' },
{ video:'mini_sandy.mp4', sound:true, cap:'mini Sandy', h:'Titolo', p:'Testo del ricordo.' },
```

- Basta indicare il solo nome del file: le cartelle (`assets/photos/`, `assets/videos/`) vengono aggiunte in automatico.
- `sound:true` aggiunge sul video il pulsante per attivare l'audio.
- Per aggiungere un ricordo, copia una voce e cambia i campi. La numerazione romana arriva a XII.

Interruttori nel codice (cercali con la ricerca del browser):

| Costante | Cosa fa |
| --- | --- |
| `FAKE_GATE` | schermata iniziale a sorpresa (`true` / `false`) |
| `TRUNK_PAUSE` | pausa prima dell'ultima parte del finale (`true` / `false`) |
| `MEDIA_TIMEOUT` | attesa massima del caricamento dei file, in millisecondi |

## Preparare foto e video

Per un caricamento veloce da telefono:

- **Foto:** circa 1000 px di larghezza, 100–300 KB ciascuna.
  ```bash
  sips -Z 1000 --setProperty formatOptions 70 *.jpg   # macOS (lavora sui file originali: fai prima una copia)
  ```
- **Video:** 540–720p, H.264, pochi MB ciascuno. Con ffmpeg (`brew install ffmpeg`):
  ```bash
  bash tools/comprimi-video.sh cartella_con_i_video
  ```
  Lo script salva i file ridotti nella sottocartella `ridotti/`, con nomi minuscoli.

Obiettivo: tutto il sito sotto i 30–40 MB.

> Dal browser GitHub accetta file fino a circa 25 MB ciascuno. Per file più grandi usa `git` da terminale o GitHub Desktop.

## Pubblicazione (GitHub Pages)

1. **Settings → Pages**.
2. Source: *Deploy from a branch* → branch `main`, cartella `/ (root)`.
3. Dopo uno o due minuti il link compare in cima alla stessa pagina:
   `https://<utente>.github.io/<repository>/`

Ogni `git push` aggiorna il sito in circa un minuto; il link non cambia.

## Controllo dei file mancanti

Aggiungi `?debug` al link del sito, per esempio:

```
https://<utente>.github.io/<repository>/?debug
```

Compare un elenco con lo stato di ogni file: `ok`, `NON TROVATO` oppure `CODEC NON SUPPORTATO`.

## Problemi comuni

| Sintomo | Causa probabile | Soluzione |
| --- | --- | --- |
| Foto o video non compare | nome diverso da quello nel codice (maiuscole, spazi) | rinomina in minuscolo e controlla con `?debug` |
| Video nero o non parte | codec HEVC (tipico dell'iPhone) | ricodifica con `tools/comprimi-video.sh` |
| Caricamento lento | file troppo pesanti | comprimi foto e video |
| Dopo un aggiornamento si vede la versione vecchia | cache del browser | ricarica la pagina o apri una scheda privata |

## Note

- Con il piano gratuito GitHub Pages richiede una repository **pubblica**: chiunque abbia il link può aprire il sito.
- I contenuti sono personali: non riutilizzare foto e testi senza permesso.