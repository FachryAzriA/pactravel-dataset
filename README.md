# PACTRAVEL - ELT Pipeline Orhcestration For Exercise 3
## TUTORIAL PENGGUNAAN REPOSITORI
1. Tools yang harus disiapkan
2. Persiapan

### 1. Tools yang harus disiapkan
- Tools :
    - Dbeaver/SQL Client
    - Docker

### 2. Persiapan
- Clone repositori pada url yang tertera (pilih branch Fachry) dengan menjalankan perintah berikut :
  ```
  # Clone
  git clone https://github.com/FachryAzriA/pactravel-dataset.git
  ```
- buat file .env pada _root directory_ dengan konfigurasi seperti berikut :
  ```
    # Source
    SRC_POSTGRES_DB=pactravel
    SRC_POSTGRES_HOST=localhost
    SRC_POSTGRES_USER=postgres
    SRC_POSTGRES_PASSWORD=mypassword
    SRC_POSTGRES_PORT=5433

    # DWH
    DWH_POSTGRES_DB=pactravel-dwh
    DWH_POSTGRES_HOST=localhost
    DWH_POSTGRES_USER=postgres
    DWH_POSTGRES_PASSWORD=mypassword
    DWH_POSTGRES_PORT=5434

    # SENTRY DSN
    SENTRY_DSN="<sentry_DSN>"

    # DIRECTORY
    # Adjust with your directory. make sure to write full path
    DIR_ROOT_PROJECT= <project_dir>   
    DIR_TEMP_LOG= <project_dir>/pipeline/temp/log      
    DIR_TEMP_DATA= <project_dir>/pipeline/temp/data           
    DIR_EXTRACT_QUERY= <project_dir>/pipeline/src_query/extract    
    DIR_LOAD_QUERY= <project_dir>/pipeline/src_query/load  
    DIR_DBT_TRANSFORM= <project_dir>/pipeline/src_query/dbt_transformdbt_transform   
    DIR_LOG=<project_dir>/logs/       
    ```
- Lakukan instalasi program-program yang diperlukan dengan menjalankan perintah berikut : 
  ```
  pip install -r requirements.txt
  ```

- Buat container docker untuk data source dan data warehouse dengan menjalankan repositori berikut :
  ```
  docker compose up -d
  ```

- Keterangan _database source_ dan _database warehouse_ adalah sebagai berikut :  
    - Source: Pactravel
    - DWH:
        - staging schema: pactravel
        - final schema: final

- Lakukan installasi package DBT yang diperlukan dengan menjalankan command berikut : 
  1. cd pipeline/src_query/dbt_transform
  2. dbt deps (install dependensi dbt yang diperlukan)
  3. dbt test (untuk memastikan tidak ada masalah) 
  4. cd ../../.. (kembali ke folder root)

- jika tidak ada masalah, jalankan sintaks berikut : 
  1. luigi --port 8082 (jalankan di cmd 1)
  2. python pipeline/transform.py (jalankan di cmd 2)
