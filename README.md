# Cookies Ku (Laravel)

## Jalankan di laptop
Salin folder app, database, resources, routes ke proyek Laravel baru,
lalu: php artisan migrate && php artisan serve

## Taruh di Render (tanpa kartu)
Upload semua isi folder ini ke GitHub (termasuk Dockerfile dan start.sh),
lalu di render.com: New > Web Service > pilih repo > Language: Docker > Instance Type: Free.
Catatan: data memakai SQLite dan bisa hilang saat server restart.
