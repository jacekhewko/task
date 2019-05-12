## Hej Tooploox! :)

Na wstępie chcę podziękować za interesujące zadanie. O dziwo nie miałem templatek na Jenkinsa więc byłem zmuszony nieco ruszyć głową i napisać wszystko po raz pierwszy. I bardzo się z tego powodu cieszę.

Muszę zaznaczyć, że miałem naprawdę mało czasu na wykonanie tego zadania (40 minut dziennie to max mojego wolnego czasu w tym momencie, a weekendy odpadają, ponieważ jestem najczęściej w podróży) - co nie zmienia faktu, że sprawiło mi to przyjemność.

Z tego też powodu nie wszystko jest tak rozwiązane, jakbym sobie tego życzył (patrz: TODO list). W tym momencie aplikacja jest deployowana w dockerze stojącym na jednym z workerów Jenkinsa. Do stu procentowej automatyzacji tego rozwiązania brakuje niewiele, ale potrzeba na to więcej czasu.

To rozwiązanie nie zawsze jest zgodne z ogólnymi zasadami bezpieczeństwa oraz nie zawsze wpasowuje się w konwencję best practice. Jako, że jest to zadanie rekrutacyjne, moim głównym celem było zrobienie tego tak, aby móc zaprezentować Wam to w jak najprostszy sposób - stąd część rzeczy nie jest zabezpieczonych hasłem, inne rzeczy są nieco uproszczone, a jeszcze gdzie indziej hasła mogą być widoczne "na zewnątrz" - właśnie ze względu na to, że jest to tylko i wyłącznie "prezentacja" i nigdy nie powinna w takiej formie trafić na "produkcję".

## Wymagania
- aws cli
- terraform
- ansible
- packer
- git

## Krótka instrukcja
1. `make init`
2. `make apply`
3. poczekać około 5. minut aby wszystkie skrypty się zainicjalizowały oraz aby slavy dodały się do puli Jenkinsa
4. <jenkins_master_ip>:8080 -> run Tooploox job (twice if first one failed)
5. <jenkins_general_build_slave_ip>:9000

voila!

## Cechy rozwiązania
- Packer tworzy AMI Jenkins mastera oraz slave przy pomocy Ansible
- Jenkins wstaje z automatycznie zainstalowanymi wtyczkami
- Jenkins wstaje z automatycznie podłączonymi workerami
- Jenkins wstaje z istniejącym, predefiniowanym Jobem
- Terraform tworzy środowisko pod Jenkinsa oraz 3 instancje Jenkinsowe, z automatycznym użyciem AMI wypieczonych dzięki Packerowi

## TODO list
### (docelowo chciałbym aby tak funkcjonowało to rozwiązanie, jednak jest to niemożliwe ze względu na ograniczony czas jaki mogę obecnie poświęcić na to zadanie)
- Udoskonalenie Jobów oraz Pipelinów (m. inn. zapisanie obrazu apki do własnego repo po jej wkonfugurowaniu)
- Wydeployowanie tej aplikacji do Elastic Container Service na AWS, wykorzystując również ECR
- Slavy Jenkinsa w autoscaling grupie
- Możliwość wydeployowania rowiązania w dowolnym regionie bez koniecznośći grzebania w kodzie (w tej chwili należy podmienić region wraz z AMI ID w `packer/jenkins.json` orac `packer/slave.json` oraz w `terraform/config.tf`)
- Security hardening (security grupy, credentiale do demo aplikacji podawane po pomocą variables itp.)
