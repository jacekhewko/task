## Hej Tooploox! :)

Na wstępie chcę podziękować za interesujące zadanie. O dziwo nie miałem templatek na Jenkinsa więc byłem zmuszony nieco ruszyć głową i napisać wszystko po raz pierwszy. I bardzo się z tego powodu cieszę.

Muszę zaznaczyć, że miałem naprawdę mało czasu na wykonanie tego zadania (40 minut dziennie to max mojego wolnego czasu w tym momencie, a weekendy odpadają, ponieważ jestem najczęściej w podróży) - co nie zmienia faktu, że sprawiło mi to przyjemność. Z tego też powodu nie wszystko jest tak rozwiązane, jakbym sobie tego życzył (patrz: TODO list). Do stu procentowej automatyzacji tego rozwiązania brakuje niewiele, ale potrzeba na to więcej czasu.

To rozwiązanie nie zawsze jest zgodne z ogólnymi zasadami bezpieczeństwa oraz nie zawsze wpasowuje się w konwencję best practice. Jako, że jest to zadanie rekrutacyjne, moim głównym celem było zrobienie tego tak, aby móc zaprezentować Wam to w jak najprostszy sposób - stąd część rzeczy nie jest zabezpieczonych hasłem, inne rzeczy są nieco uproszczone, a jeszcze gdzie indziej hasła są widoczne "na zewnątrz" - właśnie ze względu na to, że jest to tylko i wyłącznie "prezentacja" i nigdy nie powinna w takiej formie trafić na "produkcję".

## Krótka instrukcja
1. make init
2. make apply
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
- Wydeployowanie tej aplikacji w Elastic Container Service na AWS, prawdopodobnie wykorzystując również ECR
- Slavy Jenkinsa w autoscaling grupie
