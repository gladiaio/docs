# Gladia Documentation

Welcome to [Gladia](documentation)

### Development

Install the [Mintlify CLI](https://www.npmjs.com/package/mintlify) to preview the documentation changes locally. To install, use the following command

```
npm i -g mintlify
```

Run the following command at the root of your documentation (where mint.json is)

```
mintlify dev
```

#### Troubleshooting

- Mintlify dev isn't running - Run `mintlify install` it'll re-install dependencies.
- Page loads as a 404 - Make sure you are running in a folder with `mint.json`
- "Error: Could not load the "sharp" module using the darwin-arm64 runtime":

```bash
  npm uninstall -g mintlify
  npm update -g
  npm i -g mintlify
```
