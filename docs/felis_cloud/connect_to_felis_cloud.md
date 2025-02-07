# Connect to Felis Cloud

## 1. Get a Felis Cloud subscription

- Visit [https://console.cloud.google.com/marketplace/product/cloud-prod-0/felis-cloud](https://console.cloud.google.com/marketplace/product/cloud-prod-0/felis-cloud) and follow the steps to subscribe to Felis Cloud.

## 2. Get an API key

- Connect to your console at [https://api-gcp.alice-bob.com/console/](https://api-gcp.alice-bob.com/console/) using the Google account you used to subscribe to Felis Cloud.
- Go the "API KEYS" tab to create an API key

💡 **Note:** If you wish to share your Felis Cloud subscription with other people, create one API key for each person. Should the need arise, this makes it easier to control billing and revoke access rights.

## 3. Use your API key in the remote provider

Instead of the `AliceBobLocalProvider` used in most examples here, use the `AliceBobRemoteProvider` together with your API key

```
provider = AliceBobRemoteProvider('YOUR_API_KEY')
```

You may then select backends which are only available through Felis Cloud, such as the one of the [Boson 4](../reference/boson_4_chips.md) QPUs: [Boson 4A, 4B or 4C](../backends/backends_list/boson_4.md):

```
backend = provider.get_backend('QPU:1Q:BOSON_4A')
```