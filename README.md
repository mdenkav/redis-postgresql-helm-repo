# deniztest isimli, deployment amaçlı git reposudur.
Kurulum git paketi Redis ve Postgresql Helm Chart dosyaları, altyapı gereksinimlerini uçtan uca kuracak .sh dosyası ve açıklamanın olduğu README dosyasından oluşmaktadır.

Ubuntu sunucularda hazır olarak çalıştırılabilir.

Repoyu lokale aldıktan sonra içinde uçtan uca gereklilikleri kuran .sh dosyası çalıştırılır.
.sh dosyası Ubuntu sunuya sırasıyla Update yapar, git,helm,docker,kubectl,minikube kurulumlarını yapar, redis ve postgresql helm deploylarını yapar, git sürecini yönetir ve pod,node kontrollerini yapar.
