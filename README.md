# Store data in Control Room with Asset Storage

Robot examples demonstrating how to operate with various types of assets.

Both of the examples are doing the same three things:
1. An initial text content is saved into a simple text asset.
2. The previous text is retrieved, added into a dictionary, then saved into a JSON kind
   of asset.
3. The previous JSON data is retrieved back into a dictionary object, then is
   serialized and saved into a file which gets stored in the cloud. Finally, the stored
   file is retrieved from the cloud and saved locally on disk in the
   [output](./output/) directory.


## Tasks

- Python: `Py Manage Assets`
- Robot Framework: `RF Manage Assets`


## Documentation

- Python: [`robocorp.storage`](https://github.com/robocorp/robo/tree/master/storage)
- Robot Framework: [`RPA.Robocorp.Storage`](https://robocorp.com/docs/libraries/rpa-framework/rpa-robocorp-storage)
