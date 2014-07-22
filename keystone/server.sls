{%- from "keystone/map.jinja" import keystone with context %}

{{ keystone.name }}:
  pkg.installed:
    - refresh: False
    - pkgs:
      - {{ keystone.pkg }}
  service.running:
    - name: {{ keystone.service }}
    - enable: True
    - require:
      - pkg: {{ keystone.name }}

/etc/keystone:
  file.recurse:
    - source: salt://keystone/files/
    - template: jinja
    - watch_in:
      - service: {{ keystone.name }}
