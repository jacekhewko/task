## Wymagania
- aws cli
- terraform
- ansible
- packer
- git

## Krótka instrukcja
Rozwiązanie docelowo jest deployowane na AWS w regionie Irlandia, korzystając z kluczy podanych przy konfiguracji nowego profilu (`make init` uruchamia między innymi `aws configure`). Zabrakło czasu na mapping i automatyzację wszystkich regionów. Nadal można to zmienić ręcznie (patrz: TODO list).

1. `make init`
2. `make apply`
3. **Warto dać Jenkinsowi około 5. minut** aby wszystkie skrypty zainicjalizowały się w tle, oraz aby slave nody zdążyły dodać się do puli
4. Wejść w URL Jenkinsa (podanego przez terraform outputs) -> Odpalić dostępny job
5. Wejść w URL General Builds Slave na port 9000 (adres został podany wcześniej przez terraform outputs)
6. Można zalogować się do Sentry jako `test@account.pl`, pass: `justatest`
7. `make destroy`

## Cechy rozwiązania
- Packer tworzy obraz Jenkins Master oraz Jenkins Slave przy pomocy Ansible oraz wysyła je do AWS AMIs
- Terraform buduje środowisko pod Jenkinsa oraz jego dwa Worker Nody, z użyciem wcześniej "wypieczonych" za pomocą Packera AMI
- Jenkins wstaje z automatycznie zainstalowanymi wtyczkami zdefiniowanymi w `ansible/roles/jenkins/files/plugins.txt`
- Jenkins wstaje z automatycznie podłączonymi workerami (`ansible/roles/slave/files/join-master.sh`)
- Jenkins wstaje z istniejącym, predefiniowanym Jobem (`job.xml` zainicjowany w user data przez jenkins-cli.jar)
- Job `tooploox-sentry` wykonuje polecenia zdefiniowane w tym repo w `Jenkinsfile` przy pomocy modułu Pipeline
- Podstawowa konfiguracja aplikacji Sentry w pipelinie
- Aplikacja Sentry zostaje wydeployowana do kontenerów wraz z Redisem oraz PostgreSQL za pomocą docker-compose (przy użyciu `docker-compose.yml` z tego repo)

## TODO list
### (docelowo chciałbym aby tak funkcjonowało to rozwiązanie, jednak jest to niemożliwe ze względu na ograniczony czas jaki mogę obecnie poświęcić na to zadanie)
- Udoskonalenie pipeline (m. inn. zapisanie obrazu apki do własnego Docker Registry po jej wkonfugurowaniu)
- Wydeployowanie tej aplikacji do Elastic Container Service na AWS, wykorzystując również ECR
- Slavy Jenkinsa w autoscaling grupie
- Możliwość wydeployowania rowiązania w dowolnym regionie bez koniecznośći grzebania w kodzie (w tej chwili należy podmienić region wraz z AMI ID w `packer/jenkins.json`, `packer/slave.json` oraz w `terraform/config.tf`)
- Security hardening (security grupy, credentiale do demo aplikacji podawane za pomocą variables itp.)
- Przeniesienie części rzeczy z userdata do Ansibla
