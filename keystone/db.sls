{%- set name="keystone" %}

{{ name }}-db:
  mysql_database.present:
    - name: {{ name }}
  mysql_user.present:
    - name: {{ name }}
    - host: "{{ salt["pillar.get"](name + ":mysql:host","%") }}"
    - password: {{ salt["pillar.get"](name + ":mysql:password") }}
  mysql_grants.present:
    - host: "{{ salt["pillar.get"](name + ":mysql:host","%") }}"
    - grant: all privileges
    - database: "{{ name }}.*"
    - user: {{ name }}

{{ name }}_sync_db:
  cmd.run:
    - name: keystone-manage db_sync
    - require:
      - mysql_database: {{ name }}-db
      - mysql_user: {{ name }}-db
      - mysql_grants: {{ name }}-db
      - file: /etc/keystone
