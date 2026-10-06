# How it works

Two parts: a thin **client** on your sim PC, and the **controller** in the cloud. One encrypted connection joins them for the whole flight.

```text
  Your PC                                   The cloud
 ┌──────────────────────────┐             ┌───────────────────────────────────────┐
 │ X-Plane 12               │             │ Voice gateway (one per flight)        │
 │    │ aircraft state      │  telemetry  │   hear:   speech recognition          │
 │    ▼                     │ ──────────► │   decide: the controller agent        │
 │ xatc-agent client        │  your voice │           and its ATC tools           │
 │   push-to-talk, radios,  │ ◄────────── │   speak:  text to speech              │
 │   ATC audio, the window  │  ATC audio  │   watch:  monitors on every frame     │
 └──────────────────────────┘             └───────────────────────────────────────┘
                                             FAA data: procedures, frequencies,
                                             airspace, minimum altitudes
```

## One radio call

1. **You key the mic.** The client streams your audio while push-to-talk is held, beside a frame of aircraft state about once a second.
2. **Speech recognition** turns the audio into text (Amazon Transcribe, tuned for aviation phraseology).
3. **Plain code checks the basics**: is a controller on that frequency, and did your callsign come through.
4. **An AI model reads the call.** Is it a readback of what ATC just said, a request, or both?
5. **A readback is judged** item by item, quoting your own words. Code refuses any quote that is not in the transcript, then decides: accept in silence, correct one item, or ask once for a safety item.
6. **A request goes to the controller agent**, an AI model (Amazon Nova) that plays the position you called. Its job is to pick the right **tool** for what you asked: issue a taxi clearance, assign an altitude, clear an approach.
7. **The tool does the controlling.** It checks the request against the FAA's data, your scenery and the state of your flight, writes the exact phraseology, and refuses in fixed words when the data says no.
8. **Text to speech** (Amazon Polly) speaks it, the client adds the radio effect, and you hear it if you are tuned to that frequency.

Meanwhile **monitors** watch every frame of your aircraft's state and start ATC's own calls: handoffs, readback reminders, an altitude that drifted, traffic.

## Where the AI is, and where it is not

The AI model understands what you said and chooses what kind of thing a controller would do next. It does not invent the clearance.

| The model does | Code does |
|---|---|
| Classifies your transmission | Decides whether a controller is listening on that frequency |
| Judges a readback against what was said | Checks that every quoted word was really in your transmission |
| Picks the tool for your request | Checks the request against the data: runways, procedures, minimum altitudes, traffic |
| | Writes the words ATC speaks, in standard phraseology |
| | Watches your flight and starts ATC's own calls |

A model can still pick the wrong tool. When it does, the tool refuses rather than issue something the data does not support, and the cost is a retry or an "unable", not a wrong clearance. When no tool fits, ATC says "unable, I have not completed that training".

## The data

- **The FAA's published data**, updated every 28-day cycle: procedures (SIDs, STARs, approaches), fixes and airways, facility frequencies and hours, airspace boundaries, minimum vectoring and minimum IFR altitudes.
- **Your X-Plane**, asked when needed: taxiways, stands and runway use, and the weather and traffic around you. See [Your X-Plane's data](client/xplane-data.md).

## One session per flight

Each flight gets its own isolated session in the cloud, which keeps the flight's state: your clearance, where you are in the flight, what you still owe a readback for. It survives a reconnect, and it stops when the flight ends.

## Why it takes a moment to answer

Each reply involves speech recognition, one or two model calls, and speech synthesis. Expect a few seconds from releasing push-to-talk to the first word. The log's **Timing** line shows each step.
