# uuidv4

A version 4 UUID generator written in the moonbit language, referring to [RFC 4122](https://datatracker.ietf.org/doc/html/rfc4122).  

## Uasge

### Use by api

```bash
moon add Nyuudoukumo/uuidv4
```

In `moon.pkg.json`

```json
{
    "import": [
        {"path": "Nyuudoukumo/uuidv4/lib", "alias": "uuid"}
    ]
}
```

The `randomUUID()` will return a uuid as a String

```moonbit
fn main {
  println(@uuid.randomUUID())
}
```

**Notice**, this package currently relies on JavaScript FFI:

```bash
moon run --target js "src\main"
```

## Todo

- [ ] Remove JavaScript FFI
