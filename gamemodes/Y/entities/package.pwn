#define MAX_PACKAGE (200)

enum W_WEAPON_PACKAGE
{
    wp_id,
    wp_type,
    wp_owner,
    wp_weapon[13],
    wp_weaponAmmo[13],
    wp_object,
    Float:wp_pos[6],
    wp_world,
}

new WpInfo[MAX_PACKAGE][W_WEAPON_PACKAGE];


enum D_DRUG_PACAGE
{
    dp_id,
    dp_type,
    dp_owner,
    dp_drug[4],
    dp_drugAmout[4],
}

new DpInfo[MAX_PACKAGE][D_DRUG_PACAGE];

#pragma unused DpInfo