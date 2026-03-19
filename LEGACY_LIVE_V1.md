# Legacy Live Transcription API

This note captures the last documentation revision before the live API migration to `/v2/live`.

## Git Reference

- Last pre-`/v2/live` docs commit: `b555f3cb96f437afb69d0c89f7515ce8b206993b`
- `/v2/live` first appears in: `5f6857154c13ecbf16cccb54b0a0dbdab7607b77`
- Migration page appears in: `b4effb41de67e6b3c9bb65bb4cd0e5501457cd13`

## Legacy Worktree

Legacy checkout created at:

`/Users/lazgladia/Documents/code/gladia-docs-live-v1-legacy`

## Old Live API Endpoint

The old V1 live transcription WebSocket endpoint is:

`wss://api.gladia.io/audio/text/audio-transcription`

The legacy live documentation page in that checkout is:

`chapters/speech-to-text-api/pages/live-speech-recognition.mdx`

## Run The Legacy Docs

```bash
cd /Users/lazgladia/Documents/code/gladia-docs-live-v1-legacy
npm ci
npm run dev
```

Local preview:

`http://localhost:3000`

## Verification

These checks were run successfully in the legacy checkout:

- `npm ci`
- `npm run broken-links`
- `npm run dev`

## Optional Branch

If you want to keep working on that detached checkout, create a branch:

```bash
cd /Users/lazgladia/Documents/code/gladia-docs-live-v1-legacy
git switch -c legacy-live-v1-docs
```

## Serve Through ngrok

This repo now includes a helper script that:

- starts the legacy docs server if it is not already running on `3000`
- chooses a random high local port
- forwards that random port to the local docs server
- starts ngrok on `https://legacy-docs.ngrok.app`

Run it from this repository:

```bash
./scripts/serve-legacy-live-v1-ngrok.sh
```
