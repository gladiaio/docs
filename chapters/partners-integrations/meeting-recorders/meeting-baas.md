# Gladia Integration with Meeting BaaS

Meeting BaaS provides a unified API for Google Meet, Zoom, and Microsoft Teams, allowing you to easily record and transcribe meetings. By integrating Gladia with Meeting BaaS, you can leverage Gladia's advanced speech-to-text capabilities to transcribe your meeting recordings.

## Benefits of Integration

- **Single API for Multiple Platforms**: Record and transcribe meetings from Google Meet, Zoom, and Microsoft Teams through one consistent API
- **Advanced Transcription**: Utilize Gladia's accurate and feature-rich transcription service
- **Instant Availability**: Get video recordings and transcriptions immediately after meetings
- **Custom Branding**: Display your user's branding with custom names and chat messages
- **GDPR Compliance**: Meeting BaaS provides a DPA and focuses on data minimization

## Integration Methods

There are two main ways to use Gladia with Meeting BaaS:

### 1. Using Gladia as the Default Provider

When creating a bot to join a meeting, you can specify Gladia as the speech-to-text provider:
```bash
curl -X POST "https://api.meetingbaas.com/bots" \
  -H "x-meeting-baas-api-key: <MEETING_BAAS_API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{
          "meeting_url": "https://meet.google.com/xyz-abc",
          "speech_to_text": "Gladia",
          "webhook_url": "https://yourapp.com/webhook"
       }'

### 2. Retranscribing with Gladia

For existing recordings, you can use the Retranscribe Bot API to process audio with Gladia:

```bash
curl -X POST "https://api.meetingbaas.com/bots/retranscribe" \
  -H "x-meeting-baas-api-key: <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "bot_uuid": "string",
    "speech_to_text": {
      "api_key": "<GLADIA_API_KEY>",
      "provider": "Gladia"
    },
    "webhook_url": "string"
  }'
```

## Setup Instructions

### Prerequisites

1. A Meeting BaaS account with an API key
2. A Gladia account with an API key

### Integration Steps

1. **Get your Gladia API Key**:
   - [Sign up for a Gladia account](https://app.gladia.io/auth/signin) if you don't have one
   - Navigate to your API keys section and copy your key

2. **Create a Meeting BaaS Bot with Gladia**:
   - Use the API endpoint `/bots` with your Meeting BaaS API key
   - Set `"speech_to_text": "Gladia"` in your request body as shown in the example above

3. **For Retranscription**:
   - Use the `/bots/retranscribe` endpoint
   - Provide your Gladia API key in the `speech_to_text.api_key` field
   - Set `"provider": "Gladia"` to specify Gladia as the transcription service

## Response Handling

Upon successful integration, Meeting BaaS will return a response with status code 200 or 202, containing details about the transcription job.

## What's Next?

After integrating with Meeting BaaS, you can:

- Use the generated transcripts in your applications
- Set up webhook notifications for transcription events
- Explore additional Meeting BaaS features like LLM summaries and metadata extraction
- Build custom interfaces using the provided transcription data

For more information, visit the [Meeting BaaS documentation](https://docs.meetingbaas.com/) or the [Gladia documentation](https://docs.gladia.io/).
