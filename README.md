## Hej! :)

Na wstępie chcę podziękować za interesujące zadanie. O dziwo nie miałem przydatnych templatek więc byłem zmuszony nieco ruszyć głową i napisać 90% kodu od zera. I bardzo się z tego powodu cieszę.

Muszę zaznaczyć, że miałem naprawdę mało czasu na wykonanie tego zadania (30/40 minut dziennie to max mojego wolnego czasu w tym miesiącu) - co nie zmienia faktu, że sprawiło mi to przyjemność.

Z tego też powodu nie wszystko jest tak rozwiązane, jakbym sobie tego życzył (patrz: TODO list). W tym momencie aplikacja jest deployowana w dockerze stojącym na jednym z workerów Jenkinsa. Do idealnego rozwiązania brakuje niewiele, ale potrzeba na to więcej czasu.

To rozwiązanie celowo nie zawsze jest zgodne z ogólnymi zasadami bezpieczeństwa oraz nie zawsze wpasowuje się w konwencję best practice. Jako, że jest to zadanie rekrutacyjne, moim głównym celem było zrobienie tego tak, aby móc zaprezentować Wam to w jak najprostszy sposób - stąd część rzeczy nie jest zabezpieczonych hasłem, inne rzeczy są nieco uproszczone, a jeszcze gdzie indziej hasła mogą być widoczne "na zewnątrz" - właśnie ze względu na to, że jest to tylko i wyłącznie "prezentacja" i nigdy nie powinna w takiej formie trafić na "produkcję".

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
