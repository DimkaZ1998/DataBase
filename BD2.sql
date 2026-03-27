import psycopg2

DB_CONFIG = {
    'db_name': 'food_delivery_pro',
    'user': 'postgres',
    'password': 'Qweasdzx12qq',
    'host': '127.0.0.1',
    'port': '5432'
}

print('=== ДОБРО ПОЖАЛОВАТЬ В ТЕРМИНАЛ КАССИРА ===')

try:
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # ПОИСК КЛИЕНТА
    email = input('Введите email клиента: ').strip()

    cursor.execute('SELECT id, full_name FROM customers WHERE email = %s', (email,))
    user_record = cursor.fetchone()

    if user_record:
        client_id = user_record[0]
        client_name = user_record[1]
        print(f'Рады снова видеть, {client_name}')
    else:
        print('Клиент не найден. Давайте зарегистрируем.')
        client_name = input('Введите ФИО клиента: ').strip()

        cursor.execute(
            'INSERT INTO customers (full_name, email) VALUES (%s, %s) RETURNING id;',
            (client_name, email)
        )
        client_id = cursor.fetchone()[0]
        print(f'Клиент {client_name} успешно зарегистрирован (ID: {client_id}).')


    # СОЗДАНИЕ КЛИЕНТА
    cursor.execute(
        'INSERT INTO orders (customer_id, status) VALUES (%s, "Принят") RETURNING id;',
        (client_id,)
    )
    order_id = cursor.fetchone()[0]
    print(f"\nОткрыт заказ №{order_id}, начинаем добавлять блюда.")

    while True:
        item_id_input = input("\nВведите ID блюда (или 0 чтобы пробить чек):")

        if item_id_input == '0':
            break
        item_id = int(item_id_input)
        quantity = int(("ВВедите кол-во порций:"))

        cursor.execute(
            "INSERT INTO order_items (order_id,item_id,quantity) VALUES (%s,%s,%s,);",
            (order_id,item_id,quantity)
        )

        print (f"-> Добавлено: Блюдо ID{item_id}, {quantity} шт.")

        conn. commit()
        print("\n[успех] Заказ успешно сохранен в базе данных!")

        print("\n" + "=" * 50)
        print(f"Чек заказа №{order_id}")
        print(f"Клиент: {client_name}" ({email}))
        print("-" * 40)

        receipt_query = 

        SELECT m.item_name, oi.quantity, (oi.quantity * m.price) as total_price
        FROM order_items order_id
        JOIN menu_items m ON oi_item_id = m.id
        WHERE oi.order_id = %s

    except psycopg2.Error as db_error:
    print(f"\n[Критическая ошибка БД] Транзакция прервана: {db_error}")
    if conn:
        conn.rollback()
        print("Изменения отменены")
    except ValueError:
print("\n[ошибка ввода] Вы ввели буквы вместо цифр! Программа Завершена.")
if conn:
    conn.rollback()
finally:
    if 'conn' in locals() and conn:
    cursor.close()
conn.close()
print("сеанс работы с терминалом завершен.")
