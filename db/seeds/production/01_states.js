exports.seed = function (knex, Promise) {
  // Deletes ALL existing entries
  return knex('states').del()
    .then(function () {
      // Inserts seed entries
      return knex('states').insert([{
          "name": "Alabama",
          "abreviation": "AL"
        },
        {
          "name": "Alaska",
          "abreviation": "AK"
        },
        {
          "name": "Arizona",
          "abreviation": "AZ"
        },
        {
          "name": "Arkansas",
          "abreviation": "AR"
        },
        {
          "name": "California",
          "abreviation": "CA"
        },
        {
          "name": "Colorado",
          "abreviation": "CO"
        },
        {
          "name": "Connecticut",
          "abreviation": "CT"
        },
        {
          "name": "Deleware",
          "abreviation": "DE"
        },
        {
          "name": "Florida",
          "abreviation": "FL"
        },
        {
          "name": "Georgia",
          "abreviation": "GA"
        },
        {
          "name": "Hawaii",
          "abreviation": "HI"
        },
        {
          "name": "Idaho",
          "abreviation": "ID"
        },
        {
          "name": "Illinois",
          "abreviation": "IL"
        },
        {
          "name": "Indiana",
          "abreviation": "IN"
        },
        {
          "name": "Iowa",
          "abreviation": "IA"
        },
        {
          "name": "Kansas",
          "abreviation": "KS"
        },
        {
          "name": "Kentucky",
          "abreviation": "KY"
        },
        {
          "name": "Louisiana",
          "abreviation": "LA"
        },
        {
          "name": "Maine",
          "abreviation": "ME"
        },
        {
          "name": "Maryland",
          "abreviation": "MD"
        },
        {
          "name": "Massachusetts",
          "abreviation": "MA"
        },
        {
          "name": "Michigan",
          "abreviation": "MI"
        },
        {
          "name": "Minnesota",
          "abreviation": "MN"
        },
        {
          "name": "Mississippi",
          "abreviation": "MS"
        },
        {
          "name": "Missouri",
          "abreviation": "MO"
        },
        {
          "name": "Montana",
          "abreviation": "MT"
        },
        {
          "name": "Nebraska",
          "abreviation": "NE"
        },
        {
          "name": "Nevada",
          "abreviation": "NV"
        },
        {
          "name": "New Hampshire",
          "abreviation": "NH"
        },
        {
          "name": "New Jersey",
          "abreviation": "NJ"
        },
        {
          "name": "New Mexico",
          "abreviation": "NM"
        },
        {
          "name": "New York",
          "abreviation": "NY"
        },
        {
          "name": "North Carolina",
          "abreviation": "NC"
        },
        {
          "name": "North Dakota",
          "abreviation": "ND"
        },
        {
          "name": "Ohio",
          "abreviation": "OH"
        },
        {
          "name": "Oklahoma",
          "abreviation": "OK"
        },
        {
          "name": "Oregon",
          "abreviation": "OR"
        },
        {
          "name": "Pennsylvania",
          "abreviation": "PA"
        },
        {
          "name": "Rhode Island",
          "abreviation": "RI"
        },
        {
          "name": "South Carolina",
          "abreviation": "SC"
        },
        {
          "name": "South Dakota",
          "abreviation": "SD"
        },
        {
          "name": "Tennessee",
          "abreviation": "TN"
        },
        {
          "name": "Texas",
          "abreviation": "TX"
        },
        {
          "name": "Utah",
          "abreviation": "UT"
        },
        {
          "name": "Vermont",
          "abreviation": "VT"
        },
        {
          "name": "Virginia",
          "abreviation": "VA"
        },
        {
          "name": "Washington",
          "abreviation": "WA"
        },
        {
          "name": "West Virginia",
          "abreviation": "WV"
        },
        {
          "name": "Wisconsin",
          "abreviation": "WI"
        },
        {
          "name": "Wyoming",
          "abreviation": "WY"
        }
      ]);
    });
};