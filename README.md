# paf-server

This is the package for the srt based file server. It also installs the pafmonitor service that executes the import script to fetch files from the S3 bucket.

See [../TRANSFER_PROTOCOL.md](../TRANSFER_PROTOCOL.md) for the JSON protocol
used when `paf2-client` initiates an SRT file transfer with `paf-server`.

`pafserver` uses PostgreSQL during the SRT handshake to authenticate the
requesting user and verify file access. Configure it with `DATABASE_READ_URL`,
`DATABASE_URL`, `DATABASE_WRITE_URL`, or the `databasereadurl` key in
`/etc/pafserver.conf`.

To compile both `paf-server` and `paf2-client` in a reusable Ubuntu build
container with the source directories mounted from the host, run:

```bash
./build-both-in-docker.sh
```
