/root/openrc:
  file.managed:
    - contents: |
        export OS_TENANT_NAME=admin
        export OS_USERNAME=admin
        export OS_PASSWORD={{ salt['pillar.get']('keystone:keystone:admin:password') }}
        export OS_AUTH_URL="http://localhost:5000/v2.0/"
        export SERVICE_TOKEN={{ salt['pillar.get']('keystone:conf:DEFAULT:admin_token') }}
        export SERVICE_ENDPOINT=http://localhost:35357/v2.0/
    - template: jinja
