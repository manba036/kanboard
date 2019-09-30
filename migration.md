# sqliteからmysqlへのデータ移行

## 1. まずsqliteのデータをエクスポート

```bash
git clone https://github.com/oliviermaridat/kanboard-sqlite2mysql.git
cd kanboard-sqlite2mysql
./kanboard-sqlite2mysql.sh <Kanboard instance physical path> -o db-mysql.sql
```

## 2. db-mysql.sqlの先頭に下記３行を追加

```sql
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET CHARACTER SET 'utf8mb4';
SET SESSION collation_connection = 'utf8mb4_general_ci';
```

## 3. kanboardのログイン画面にアクセス（ログインはしない）

このアクションによってkanboardデータベース内に各種初期デーブルが生成される

## 4. mysqlにデータをインポート

```bash
docker exec -it db bash
mysql -u root -p kanboard < /data/db-mysql_new.sql
```
