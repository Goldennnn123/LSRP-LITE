stock SaveWp(id, thread = MYSQL_TYPE_THREAD)
{
    new query[MAX_STRING];

    mysql_init("weapons_package", "wp_id", WpInfo[id][wp_id], thread);

    mysql_int(query, "wp_owner",WpInfo[id][wp_owner]);
    mysql_int(query, "wp_type",WpInfo[id][wp_type]);

    for(new w = 1; w <= 12; w++)
    {
        mysql_int(query, "wp_weapon%d",WpInfo[id][wp_weapon][w]);
        mysql_int(query, "wp_weaponAmmo%d",WpInfo[id][wp_weapon][w]);
    }

    mysql_flo(query, "wp_posx",WpInfo[id][wp_pos][0]);
    mysql_flo(query, "wp_posy",WpInfo[id][wp_pos][1]);
    mysql_flo(query, "wp_posz",WpInfo[id][wp_pos][2]);
    mysql_finish(query);

    return 1;
}