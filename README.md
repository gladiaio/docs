# Gladia Documentation

Welcome to [Gladia Documentation](https://docs.gladio.io)

> [!NOTE]
> To access V1 documentation (deprecation April 1st, 2024) click [Here](https://docs-v1.gladia.io)

### Installing dependencies

```bash
npm i
```

### Development

Run the following command at the root of your documentation (where mint.json is) to run a local development server

```bash
npm run dev
```

### Checking broken links

The following command will check the documentation for any formatting error or broken links

```bash
npm run broken-links
```

#### Troubleshooting

You may need to install the [Mintlify CLI](https://www.npmjs.com/package/mintlify) to preview the documentation changes locally. To install, use the following command

```bash
npm i -g mintlify
```

##### Other common issues

- Mintlify dev isn't running - Run `mintlify install` it'll re-install dependencies.
- Page loads as a 404 - Make sure you are running in a folder with `mint.json`
- Openapi.json not taken in account in API Reference, stop and relaunch server
- 'Error: Could not load the "sharp" module using the darwin-arm64 runtime':

```bash
  npm uninstall -g mintlify
  npm update -g
  npm i -g mintlify
```
