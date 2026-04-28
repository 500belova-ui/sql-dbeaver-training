# DBeaver Training

## Цель

Научиться работать с базой данных через DBeaver:

- подключаться к базе;
- смотреть структуру таблиц;
- смотреть данные;
- писать SQL-запросы;

## Что внутри базы

Учебная база имитирует небольшой интернет-магазин.

В базе есть таблицы:

- users — пользователи;
- categories — категории товаров;
- products — товары;
- orders — заказы;
- order_items — товары внутри заказов;
- payments — платежи;
- shipments — доставки;
- support_tickets — обращения в поддержку.

## Как запустить базу

1. Установить Docker Desktop.
2. Открыть проект в PyCharm или любой другой IDE.
3. Открыть терминал в папке проекта.
4. Выполнить команду:

```bash
docker compose up -d
```

## Данные для подключения в DBeaver

- **Host:** localhost  
- **Port:** 5432  
- **Database:** qa_shop  
- **Username:** qa_user  
- **Password:** qa_password  

---

## Как подключиться через DBeaver

1. Открыть DBeaver  
2. Нажать **New Database Connection**  
3. Выбрать **PostgreSQL**  
4. Ввести данные подключения  
5. Нажать **Test Connection**  
6. Если подключение успешно — нажать **Finish**
