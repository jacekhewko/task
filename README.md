## Hej Tooploox! :)

Na wstępie chcę podziękować za interesujące zadanie. O dziwo nie miałem templatek na Jenkinsa więc byłem zmuszony nieco ruszyć głową i napisać wszystko po raz pierwszy. I bardzo się z tego powodu cieszę.

Muszę zaznaczyć, że miałem naprawdę mało czasu na wykonanie tego zadania (40 minut dziennie to max mojego wolnego czasu w tym momencie, a weekendy odpadają, ponieważ jestem najczęściej w podróży) - co nie zmienia faktu, że sprawiło mi to przyjemność. Z tego też powodu nie wszystko jest tak rozwiązane, jakbym sobie tego życzył (patrz: TODO list). Do stu procentowej automatyzacji tego rozwiązania brakuje niewiele, ale potrzeba na to więcej czasu.

To rozwiązanie nie zawsze jest zgodne z ogólnymi zasadami bezpieczeństwa oraz nie zawsze wpasowuje się w konwencję best practice. Jako, że jest to zadanie rekrutacyjne, moim głównym celem było zrobienie tego tak, aby móc zaprezentować Wam to w jak najprostszy sposób - stąd część rzeczy nie jest zabezpieczonych hasłem, inne rzeczy są nieco uproszczone, a jeszcze gdzie indziej hasła są widoczne "na zewnątrz" - właśnie ze względu na to, że jest to tylko i wyłącznie "prezentacja" i nigdy nie powinna w takiej formie trafić na "produkcję".

## Krótka instrukcja
- `packer build packer/jenkins.json`
- /terraform/config.tf - uzupełnienie credentiali AWS
- `terraform apply`
- ${ip_address}:8080
- 

## Cechy rozwiązania
- Packer tworzy AMI Jenkins mastera oraz slave przy pomocy Ansible
- Jenkins wstaje z automatycznie zainstalowanymi wtyczkami
- Jenkins wstaje z automatycznie podłączonymi workerami
- Terraform tworzy środowisko pod Jenkinsa oraz 3 instancje Jenkinsowe, z automatycznym użyciem AMI wypieczonych dzięki Packerowi

## TODO list
### (docelowo chciałbym aby tak funkcjonowało to rozwiązanie, jednak jest to niemożliwe ze względu na ograniczony czas jaki mogę obecnie poświęcić na to zadanie)
- Wydeployowanie tej aplikacji w Elastic Container Service na AWS, prawdopodobnie wykorzystując również ECR
- Projekt/Job Jenkinsa powinien być dostępny od razu po jego wydeployowaniu, bez konieczności przeklikiwania tego w przeglądarce
- Jenkins Slaves automatycznie się podłączają do Mastera (jest to łatwe - sporo jest nawet gotowych skryptów w internecie - natomiast bardzo utrudniłem sobie sprawę wyłączając usera na Jenkinsie, o czym zorientowałem się za późno :))
- Slavy Jenkinsa umieściłbym prawdopodobnie w autoscaling grupie
- Więcej security group z bezpieczniej ustalonymi rulami






Please be aware that this solution is not created in a best-practice fashion, as it is aimed to be a showcase, not for real-life production environment use case. Due to lack of time, my main goal was to make it easy to review for you. This is not secure.

docker-compose up -d && seckey=$(docker-compose run --rm sentry config generate-secret-key) && echo "Y jacek.hewko@gmail.com testpass testpass y" | docker-compose run --rm sentry upgrade

- Run Jenkins
- Install Pipeline plugin
- Install GitHub plugin
- Create new project -> Pipeline -> Jenkinsfile SCM from Git


sudo yum -y install git
sudo yum -y install docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


docker-compose up -d
docker-compose run --rm sentry config generate-secret-key
powinno Ci wygenerowac klucz, copy and paste w .variables, zapisz i odpak ostatnia komende
docker-compose run --rm sentry upgrade


docker-compose up -d && seckey=$(docker-compose run --rm sentry config generate-secret-key) && echo "Y jacek.hewko@gmail.com testpass testpass y" | docker-compose run --rm sentry upgrade


https://github.com/jacekhewko/tooploox.git

