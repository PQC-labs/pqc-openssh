# Experiment 003 - Native PQC in OpenSSH

## Objective

Study the native post-quantum hybrid key exchange algorithms implemented in OpenSSH 10.x.

The experiment focuses on observing and validating the negotiated key exchange algorithms without modifying the OpenSSH source code.

## Running the Laboratory

From the experiment directory:

```bash
docker compose up -d
```

Verify that both containers are running:

```bash
docker compose ps
```

Expected output:

```
pqc_lab003-openssh-client   Up
pqc_lab003-openssh-server   Up
```

## Testing SSH Connectivity

Open a shell inside the client container:

```bash
docker compose exec client bash
```

Connect to the server:

```bash
ssh -i /keys/id_ed25519 researcher@server
```

Expected result:

```
researcher@server:~$
```

## Related Documentation

- Repository README
- `docs/experiments/003-native-pqc.md`

---

## Status

✅ Completed