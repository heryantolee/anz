if __name__ == '__main__':

    # Define the sample data as a list of tuples
    sample = [
        (1, 10),
        (1, 11),
        (2, 13),
        (3, 10),
        (3, 11),
        (4, 13),
        (4, 14)
    ]

    # Group customer_id, string aggregate account_id into string_array
    agg_account_id = {}
    for customer_id, account_id in sample:
        if customer_id not in agg_account_id:
            agg_account_id[customer_id] = [str(account_id)]
        else:
            agg_account_id[customer_id].append(str(account_id))

    # Count customer_id based on array_account_id
    count_customer_id = {}
    for array_account_id in agg_account_id.values():
        array_account_id_str = ','.join(sorted(array_account_id))
        if array_account_id_str not in count_customer_id:
            count_customer_id[array_account_id_str] = 1
        else:
            count_customer_id[array_account_id_str] += 1

    # Show customer_id that have exactly the same account_id
    result = []
    for customer_id, array_account_id in agg_account_id.items():
        array_account_id_str = ','.join(sorted(array_account_id))
        if count_customer_id[array_account_id_str] >= 2:
            result.append((customer_id, array_account_id_str))

    # Print the result
    for customer_id, array_account_id in result:
        print("customer_id:", customer_id)
        print("array_account_id:", array_account_id)
