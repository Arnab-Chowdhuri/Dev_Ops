# output "ami_nginx" {
#   value       = data.aws_ami.nginx_AMI.id
#   description = "AMI of FE Instance -> Nginx."
# }

# output "FE_Instance_Public_IP" {
#   value = aws_instance.FE-instance.public_ip
#   description = "Public Ip of FE Instance"
# }


- name: Check if .git directory exists
    stat:
        path: /home/ubuntu/new_chatapp/.git
    register: git_repo_status

- name: Clone the repository if .git directory doesn't exist
    git:
        repo: your_repository_url
        dest: /home/ubuntu/your_repository
    when: git_repo_status.stat.exists == false

- name: Replace old database configuration with new one in settings.py
    replace:
        path: /path/to/your/settings.py
        regexp: "{{ item.regexp }}"
        replace: "{{ item.replace }}"
    with_items:
        - { regexp: "'NAME': 'mysqldb',", replace: "'NAME': 'rds_db'," }
        - { regexp: "'PASSWORD': 'admin12345',", replace: "'PASSWORD': 'Supriyo12'," }
        - { regexp: "'HOST': 'mysqldb.ckz7bawd2dzf.ap-south-1.rds.amazonaws.com',", replace: "'HOST': 'db-instance.cbgws8sq28an.ap-south-1.rds.amazonaws.com'," }


- name: Create user
  mysql_user:
    name: root
    password: mysql1234
    login_host: localhost

- name: Creating new mysql user
  mysql_user:
    name: root
    password: mysql1234
    login_host: localhost
    login_user: root
    login_password: mysql1234

- name: Check if database configuration exists
  shell: "grep -q \"'NAME': 'mysql_db'\" /home/ubuntu/new_chatapp/fundoo/fundoo/settings.py"
  register: db_config_exists
  changed_when: false

- name: Creating new mysql user
  mysql_user:
    name: root
    password: mysql1234
    login_host: localhost
    login_user: root
    login_password: mysql1234

- name: creating chat_db database
  mysql_db:
    name: mysql_db
    login_host: localhost
    login_user: root
    login_password: mysql1234

      #- name: Replace old database configuration with new one in settings.py
      #replace:
      # path: /home/ubuntu/new_chatapp/fundoo/fundoo/settings.py
      # regexp: "{{ item.regexp }}"
      # replace: "{{ item.replace }}"
      #  with_items:
      # - { regexp: "'NAME': 'mysqldb',", replace: "'NAME': 'mysql_db'," }
      # - { regexp: "'PASSWORD': 'admin12345',", replace: "'PASSWORD': 'mysql1234'," }
      # - { regexp: "'HOST': 'mysqldb.ckz7bawd2dzf.ap-south-1.rds.amazonaws.com',", replace: "'HOST': 'localhost'," }
- name: editing settings.py file to change db configs
  blockinfile:
    path: /home/ubuntu/new_chatapp/fundoo/fundoo/settings.py
    marker_begin: "DATABASES = {"
    marker_end: "}"
    block: |-
      'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mysql_db',
        'USER': 'root',
        'PASSWORD': 'mysql1234',
        'HOST': 'localhost',
        'PORT': '3306'
      }

ansible@ip-172-31-35-135:~/My_3tire_playbook$ vim create_mysql_users.sql
ansible@ip-172-31-35-135:~/My_3tire_playbook$ mysql -uroot -p'' < create_mysql_users.sql^C
