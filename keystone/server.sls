{%- from "keystone/map.jinja" import keystone with context %}

{{ keystone.name }}:
  pkg.installed:
    - refresh: False
    - name: {{ keystone.pkg }}
  service.running:
    - name: {{ keystone.service }}
    - enable: True
    - require:
      - pkg: {{ keystone.name }}

{{ keystone.name }}_sync_db:
  cmd.run:
    - name: keystone-manage db_sync
    - require:
      - file: /etc/keystone/keystone.conf

/etc/keystone/keystone.conf:
  file.managed:
    - source: salt://keystone/files/keystone.conf
    - template: jinja
