Config = {}
Translation = {}

Config.Locale                     = 'de'
Config.Distance                   = 2 -- Distance where you can open the Menu
Config.Debug                      = true --Noch nicht ganz zu gebrauchen 
Config.Color                      = {r = 125, g = 0, b = 0, a = 255}
Config.price                      = 80


Config.Zones = {
    Pos = {x = 338.66809082031, y = -1562.7145996094, z = 29.298038482666},
    Example = {x = 0, y = 0, z = 0} -- if you want to add more then one you need to do it like this.
}

Translation = {
    ['de'] = {
        ['Admission_office'] = 'Zulassungsstelle',
        ['Platechange'] = 'änder dein nummernschild für nur 10€',
        ['insert_plate_txt'] = 'Füge hier deine Custom nummernschild text ein',
        ['subtitle'] = 'Put The Cookie Down',
        ['header'] = 'Nummernschild ändern'
    },

    ['en'] = {
        ['Admission_office'] = 'Admission Office',
        ['Platechange'] = 'Change The License Plate for Only 10$',
        ['insert_plate_txt'] = 'Insert your Custom Plate Text',
        ['subtitle'] = 'Put The Cookie Down',
        ['header'] = 'Change your Numberplate'
    }
}