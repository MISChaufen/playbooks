# PowerDNS authoritative

## Requirements
Ansible module for [powerdns](https://github.com/fluepke/ansible-module-powerdns) must be available to ansible.

## Configuration
See `defaults/main.yml` for a list of options.
Basically all [authoritative server options](https://doc.powerdns.com/authoritative/) are exposed.
Webserver and API are enabled by default, because API is needed in letsencrypt role.

`powerdns_authoritative__launch`: Specify a list of backends to use. If `gsqlite` or `gpgsql` are in the list, special tasks for those backends (`configure_sqlite3.yml`, `configure_postgresql.yml`) are executed.
`powerdns_authoritative__api_key: changeme` API key to use

### Database configuration
For *PostgreSQL*:
```yaml
powerdns_authoritative__gpgsql_host: localhost
powerdns_authoritative__gpgsql_port: 5432
powerdns_authoritative__gpgsql_dbname: powerdns
powerdns_authoritative__gpgsql_user: powerdns
powerdns_authoritative__gpgsql_password: changeme
powerdns_authoritative__gpgsql_dnssec: true
```

For *SQLite3*:
```yaml
powerdns_authoritative__gsqlite_database: /var/lib/powerdns/db.sqlite
powerdns_authoritative__gsqlite_pragma_synchronous: 0
powerdns_authoritative__gsqlite_pragma_foreign_keys: true
powerdns_authoritative__gsqlite_dnssec: true
powerdns_authoritative__regenerate_sqlite3: false
```

### Zones
```yaml
powerdns_authoritative__zones:
  - name: example.com.
    nameservers: [ns1.example.com, ns2.example.com]
    records:
      # CAA
      - name: example.com.
        type: CAA
        content: '0 issue "letsencrypt.org"'
      - name: example.com.
        type: CAA
        content: '0 issuewild ";"'  # no wildcards
      - name: example.com.
        type: CAA
        content: '0 iodef "mailto:security@luepke.email"'
      # Mail records
      - name: example.com.
        type: MX
        content: '10 smtp.example.com.'
```

