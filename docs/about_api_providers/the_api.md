# The API

If you want to integrate Felis with other tools, you may need to interact directly with our API.

It can be accessed at [https://api.alice-bob.com/v1/](https://api.alice-bob.com/v1/).

Here’s an example listing all jobs, pending or completed:

```python
curl --request GET \
  --url https://api.alice-bob.com//v1/jobs/ \
  --header 'Authorization: Basic <API key>'
```

Note the use of an API key: this is the same API key as the one used with the Qiskit provider `AliceBobRemoteProvider(api_key=<API key>)`. That’s because the Qiskit provider interacts with the API.

Use the same API key with the API as with the Qiskit provider `AliceBobRemoteProvider`. That’s because the provider itself is backed by the API. For more information, see [Install the Qiskit provider](../getting_started/install_the_qiskit_provider.md).

The up-to-date API reference can be accessed here: 

[Alice & Bob - Cloud API - ReDoc](https://api.alice-bob.com/reference)