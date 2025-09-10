import requests

BASE_URL = "http://localhost:8000/api/"
PROJECT_TYPE_URL = f"{BASE_URL}project-types/"
PROJECT_CATEGORY_URL = f"{BASE_URL}project-categories/"
PROJECT_SUB_CATEGORY_URL = f"{BASE_URL}project-sub-categories/"
PROJECT_STYLE_URL = f"{BASE_URL}project-styles/"

project_types = ['Décor', 'Renovation', 'Repair', 'Craft & Hobbies', 'Smart Home']


def get_all_data(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.json()
        else:
            print(f"Failed to get data from {url}. Status Code: {response.status_code}")
            return []
    except Exception as e:
        print(f"Error occurred while getting data: {e}")
        return []


def delete_data_by_id(url, item_id):
    try:
        response = requests.delete(f"{url}{item_id}/")
        if response.status_code == 204:
            print(f"Successfully deleted data with ID: {item_id}")
        else:
            print(f"Failed to delete data with ID {item_id}. Status Code: {response.status_code}")
    except Exception as e:
        print(f"Error occurred while deleting data with ID {item_id}: {e}")


def delete_existing_data():
    types_data = get_all_data(PROJECT_TYPE_URL)
    for item in types_data['data']:
        delete_data_by_id(PROJECT_TYPE_URL, item['id'])

    categories_data = get_all_data(PROJECT_CATEGORY_URL)
    for item in categories_data['data']:
        delete_data_by_id(PROJECT_CATEGORY_URL, item['id'])

    sub_categories_data = get_all_data(PROJECT_SUB_CATEGORY_URL)
    for item in sub_categories_data['data']:
        delete_data_by_id(PROJECT_SUB_CATEGORY_URL, item['id'])

    styles_data = get_all_data(PROJECT_STYLE_URL)
    for item in styles_data['data']:
        delete_data_by_id(PROJECT_STYLE_URL, item['id'])


def post_project_types():
    for project_type in project_types:
        data = {'type': project_type}
        response = requests.post(PROJECT_TYPE_URL, json=data)
        if response.status_code == 201:
            print(f"Successfully posted project type: {project_type}")
        else:
            print(
                f"Failed to post project type: {project_type}, Status code: {response.status_code}, Response: {response.text}")


def post_project_categories():
    categories = {
        'Décor': ['Living Room', 'Bedrooms', 'Bathrooms', 'Home Office', 'Basement', 'Dining', 'Loft', 'Laundry',
                  'Closet', 'Kids Space', 'College & Teen Space', 'Home Gym', 'Patio & Gardening Decor'],
        'Renovation': ['Kitchen Overhauls', 'Bathroom Renovations', 'Wall Treatments', 'Furniture',
                       'Cabinets', 'Flooring', 'Lighting', 'Basement Renovation', 'Inside Storage & Organization',
                       'Decks and Patios', 'Landscaping', 'Outdoor Storage & Organization'],
        'Repair': ['Upcycling', 'Building', 'Restoration', 'Assembly', 'Lighting', 'Landscape Repairs',],
        'Craft & Hobbies': ['Scrapbooking', 'Knitting and Crocheting', 'Jewelry Making', 'Holiday Arts and Crafts',
                            'General Crafts', 'Kids Projects'],
        'Smart Home': ['Home Automation', 'Security Systems', 'Energy Efficiency', 'Entertainment', 'Lighting']
    }

    for project_type, categories_list in categories.items():
        type_id = get_id_from_name(PROJECT_TYPE_URL, project_type)
        if not type_id:
            print(f"Project Type {project_type} not found. Skipping categories.")
            continue
        for category in categories_list:
            data = {'type': type_id, 'category': category}
            response = requests.post(PROJECT_CATEGORY_URL, json=data)
            if response.status_code == 201:
                print(f"Successfully posted category: {category} under project type: {project_type}")
            else:
                print(
                    f"Failed to post category: {category} under project type: {project_type}, Status code: {response.status_code}, Response: {response.text}")


def post_project_sub_categories():
    sub_categories = {
        'Living Room': ['Living Room'],
        'Bedrooms': ['Bedrooms'],
        'Bathrooms': ['Bathrooms'],
        'Home Office': ['Home Office'],
        'Basement': ['Basement'],
        'Dining': ['Dining'],
        'Loft': ['Loft'],
        'Laundry': ['Laundry'],
        'Closet': ['Closet'],
        'Kids Space': ['Kids Space'],
        'College & Teen Space': ['Dorm Room', 'Apartment', 'Shared Living Space'],
        'Home Gym': ['Home Gym'],
        'Patio & Gardening Decor': ['Patio Decor', 'Gardening Decor', ]
    }
    sub_categories2 = {
        'Living Room': ['Living Room'],
        'Bedrooms': ['Bedrooms'],
        'Bathrooms': ['Bathrooms'],
        'Home Office': ['Home Office'],
        'Basement': ['Basement'],
        'Dining': ['Dining'],
        'Loft': ['Loft'],
        'Laundry': ['Laundry'],
        'Closet': ['Closet'],
        'Kids Space': ['Kids Space'],
        'College & Teen Space': ['Dorm Room', 'Apartment', 'Shared Living Space'],
        'Home Gym': ['Home Gym'],
        'Patio & Gardening Decor': ['Patio Decor', 'Gardening Decor', ]
    }
    for category, sub_categories_list in sub_categories.items():
        category_id = get_id_from_name(PROJECT_CATEGORY_URL, category)
        if not category_id:
            print(f"Category {category} not found. Skipping sub-categories.")
            continue
        for sub_category in sub_categories_list:
            data = {'category': category_id, 'sub_category': sub_category}
            response = requests.post(PROJECT_SUB_CATEGORY_URL, json=data)
            if response.status_code == 201:
                print(f"Successfully posted sub-category: {sub_category} under category: {category}")
            else:
                print(
                    f"Failed to post sub-category: {sub_category} under category: {category}, Status code: {response.status_code}, Response: {response.text}")


def post_project_styles():
    {
      "categories": {
        "Décor": [
          {
            "title": "Living Room",
            "sub_categories": [
              {
                "title": "Living Room",
                "styles": [
                  {"title": "Contemporary"},
                  {"title": "Traditional"},
                  {"title": "Midcentury Modern"},
                  {"title": "Farmhouse"},
                  {"title": "Transitional"},
                  {"title": "Industrial"},
                  {"title": "Scandinavian"},
                  {"title": "Rustic"},
                  {"title": "Coastal"},
                  {"title": "Eclectic"},
                  {"title": "Southwestern"},
                  {"title": "Tropical"},
                  {"title": "Craftsman"},
                  {"title": "Asian"},
                  {"title": "Victorian"},
                  {"title": "Mediterranean"},
                  {"title": "French Country"},
                  {"title": "Shabby Chic"}
                ]
              }
            ]
          },
          {
            "title": "Bedrooms",
            "sub_categories": [
              {
                "title": "Bedrooms",
                "styles": [
                  {"title": "Contemporary"},
                  {"title": "Traditional"},
                  {"title": "Midcentury Modern"},
                  {"title": "Farmhouse"},
                  {"title": "Transitional"},
                  {"title": "Industrial"},
                  {"title": "Scandinavian"},
                  {"title": "Rustic"},
                  {"title": "Coastal"},
                  {"title": "Eclectic"},
                  {"title": "Southwestern"},
                  {"title": "Tropical"},
                  {"title": "Craftsman"},
                  {"title": "Asian"},
                  {"title": "Victorian"},
                  {"title": "Mediterranean"},
                  {"title": "French Country"},
                  {"title": "Shabby Chic"}
                ]
              }
            ]
          },
          {
            "title": "Bathrooms",
            "sub_categories": [
              {
                "title": "Bathrooms",
                "styles": [
                  {"title": "Contemporary"},
                  {"title": "Traditional"},
                  {"title": "Midcentury Modern"},
                  {"title": "Farmhouse"},
                  {"title": "Transitional"},
                  {"title": "Industrial"},
                  {"title": "Scandinavian"},
                  {"title": "Rustic"},
                  {"title": "Coastal"},
                  {"title": "Eclectic"},
                  {"title": "Southwestern"},
                  {"title": "Tropical"},
                  {"title": "Craftsman"},
                  {"title": "Asian"},
                  {"title": "Victorian"},
                  {"title": "Mediterranean"},
                  {"title": "French Country"},
                  {"title": "Shabby Chic"}
                ]
              }
            ]
          },
          {
                  "title": "Home Office",
                  "sub_categories": [
                    {
                      "title": "Home Office",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Basement",
                  "sub_categories": [
                    {
                      "title": "Basement",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Dining",
                  "sub_categories": [
                    {
                      "title": "Dining",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Loft",
                  "sub_categories": [
                    {
                      "title": "Loft",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Laundry",
                  "sub_categories": [
                    {
                      "title": "Laundry",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Closet",
                  "sub_categories": [
                    {
                      "title": "Closet",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Traditional"},
                        {"title": "Midcentury Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Transitional"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Eclectic"},
                        {"title": "Southwestern"},
                        {"title": "Tropical"},
                        {"title": "Craftsman"},
                        {"title": "Asian"},
                        {"title": "Victorian"},
                        {"title": "Mediterranean"},
                        {"title": "French Country"},
                        {"title": "Shabby Chic"}
                      ]
                    }
                  ]
                },
          {
            "title": "Kids Space",
            "sub_categories": [
              {
                "title": "Kids Space",
                "styles": [
                  {"title": "Sports"},
                  {"title": "Beachy Theme Rooms"},
                  {"title": "Educational"},
                  {"title": "Fantasy"},
                  {"title": "Gender Neutral"},
                  {"title": "Modern Minimalist"},
                  {"title": "Eco-Friendly"},
                  {"title": "Vintage"},
                  {"title": "Playful"},
                  {"title": "Traditional"},
                  {"title": "Midcentury Modern"},
                  {"title": "Farmhouse"}
                ]
              }
            ]
          },
           {
                  "title": "College & Teen Space",
                  "sub_categories": [
                    {
                      "title": "Dorm Room",
                      "styles": [
                        {"title": "Modern"},
                        {"title": "Bohemian"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Urban"},
                        {"title": "Classic"},
                        {"title": "Preppy"},
                        {"title": "Minimalist"},
                        {"title": "Eco-Friendly"},
                        {"title": "Artistic"}
                      ]
                    },
                    {
                      "title": "Apartment",
                      "styles": [
                        {"title": "Modern"},
                        {"title": "Farmhouse"},
                        {"title": "Industrial"},
                        {"title": "Chic"},
                        {"title": "Eclectic"},
                        {"title": "Midcentury Modern"},
                        {"title": "Coastal"},
                        {"title": "Traditional"},
                        {"title": "Transitional"},
                        {"title": "Boho-Chic"},
                        {"title": "Contemporary"},
                        {"title": "Rustic"}
                      ]
                    },
                    {
                      "title": "Shared Living Space",
                      "styles": [
                        {"title": "Collaborative"},
                        {"title": "Urban Loft"},
                        {"title": "Neutral"},
                        {"title": "Vibrant"},
                        {"title": "Casual"},
                        {"title": "Functional"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Home Gym",
                  "sub_categories": [
                    {
                      "title": "Home Gym",
                      "styles": [
                        {"title": "Modern"},
                        {"title": "Industrial"},
                        {"title": "Minimalist"},
                        {"title": "Coastal"},
                        {"title": "Rustic"},
                        {"title": "Zen"},
                        {"title": "Luxury"},
                        {"title": "Functional"},
                        {"title": "Vintage"},
                        {"title": "Sporty"}
                      ]
                    }
                  ]
                },
                {
                  "title": "Patio & Gardening Decor",
                  "sub_categories": [
                    {
                      "title": "Patio Decor",
                      "styles": [
                        {"title": "Contemporary"},
                        {"title": "Rustic"},
                        {"title": "Coastal"},
                        {"title": "Industrial"},
                        {"title": "Scandinavian"},
                        {"title": "Farmhouse"},
                        {"title": "Mediterranean"},
                        {"title": "Bohemian"}
                      ]
                    },
                    {
                      "title": "Gardening Decor",
                      "styles": [
                        {"title": "Cottage"},
                        {"title": "Formal"},
                        {"title": "Wildlife-Friendly"},
                        {"title": "Zen Garden"},
                        {"title": "Tropical"},
                        {"title": "Modern"},
                        {"title": "Vintage"}
                      ]
                    }
                  ]
                }
        ],
        "Renovation": [
          {
            "title": "Kitchen Overhauls",
            "sub_categories": [
              {
                "title": "Kitchen Overhauls",
                "styles": []
              }
            ]
          },
          {
            "title": "Bathroom Renovations",
            "sub_categories": [
              {
                "title": "Bathroom Renovations",
                "styles": []
              }
            ]
          },
           {
                "title": "Wall Treatments",
                "sub_categories": [
                  {
                    "title": "Wallpaper",
                    "styles": []
                  },
                  {
                    "title": "Paneling",
                    "styles": []
                  },
                  {
                    "title": "Shiplap",
                    "styles": []
                  },
                  {
                    "title": "Painting",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Furniture",
                "sub_categories": [
                  {
                    "title": "Furniture",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Cabinets",
                "sub_categories": [
                  {
                    "title": "Cabinets",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Flooring",
                "sub_categories": [
                  {
                    "title": "Tile",
                    "styles": []
                  },
                  {
                    "title": "Hardwood",
                    "styles": []
                  },
                  {
                    "title": "Laminate",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Lighting",
                "sub_categories": [
                  {
                    "title": "Fixtures",
                    "styles": [
                      {"title": "Modern"},
                      {"title": "Traditional"},
                      {"title": "Industrial"}
                    ]
                  },
                  {
                    "title": "Smart Lighting",
                    "styles": [
                      {"title": "Motion Sensors"},
                      {"title": "App-Controlled Systems"}
                    ]
                  },
                  {
                    "title": "Ambient Lighting",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Basement Renovation",
                "sub_categories": [
                  {
                    "title": "Waterproofing",
                    "styles": []
                  },
                  {
                    "title": "Finishing",
                    "styles": []
                  },
                  {
                    "title": "Flooring",
                    "styles": []
                  },
                  {
                    "title": "Soundproofing",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Inside Storage & Organization",
                "sub_categories": [
                  {
                    "title": "Built-in Shelves",
                    "styles": []
                  },
                  {
                    "title": "Laundry Room Organization",
                    "styles": []
                  },
                  {
                    "title": "Bathroom Storage",
                    "styles": []
                  },
                  {
                    "title": "Closet Organization",
                    "styles": []
                  },
                  {
                    "title": "Kitchen Storage",
                    "styles": []
                  },
                  {
                    "title": "Garage Storage",
                    "styles": []
                  },
                  {
                    "title": "Entryway Organization",
                    "styles": []
                  },
                  {
                    "title": "Toy Storage",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Decks and Patios",
                "sub_categories": [
                  {
                    "title": "Refurbishing",
                    "styles": []
                  },
                  {
                    "title": "Decorating",
                    "styles": []
                  },
                  {
                    "title": "Seasonal Prep",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Landscaping",
                "sub_categories": [
                  {
                    "title": "Garden Layouts",
                    "styles": []
                  },
                  {
                    "title": "Plant Selection",
                    "styles": []
                  },
                  {
                    "title": "Hardscaping",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Outdoor Storage & Organization",
                "sub_categories": [
                  {
                    "title": "Sheds",
                    "styles": []
                  },
                  {
                    "title": "Garden Storage",
                    "styles": []
                  },
                  {
                    "title": "Pool Storage",
                    "styles": []
                  }
                ]
              }
        ],
        "Repair": [
           {
               "title": "Upcycling",
               "sub_categories": [
                 {
                   "title": "Furniture",
                   "styles": []
                 },
                 {
                   "title": "Decor",
                   "styles": []
                 },
                 {
                   "title": "Textiles",
                   "styles": []
                 }
               ]
             },
             {
               "title": "Building",
               "sub_categories": [
                 {
                   "title": "Custom Shelving",
                   "styles": []
                 },
                 {
                   "title": "Storage Solutions",
                   "styles": []
                 },
                 {
                   "title": "Small Furniture",
                   "styles": []
                 }
               ]
             },
             {
               "title": "Restoration",
               "sub_categories": [
                 {
                   "title": "Wooden Furniture",
                   "styles": []
                 },
                 {
                   "title": "Metal Furniture",
                   "styles": []
                 },
                 {
                   "title": "Upholstery",
                   "styles": []
                 }
               ]
             },
             {
               "title": "Assembly",
               "sub_categories": [
                 {
                   "title": "Flat-Pack Furniture",
                   "styles": [
                     {"title": "Ikea"},
                     {"title": "Wayfair"}
                   ]
                 },
                 {
                   "title": "Outdoor Furniture",
                   "styles": [
                     {"title": "Patio Sets"},
                     {"title": "Grilling Stations"}
                   ]
                 },
                 {
                   "title": "Exercise Equipment",
                   "styles": []
                 }
               ]
             },
             {
               "title": "Lighting",
               "sub_categories": [
                 {
                   "title": "Fixture Replacement",
                   "styles": []
                 },
                 {
                   "title": "Rewiring Basics",
                   "styles": []
                 }
               ]
             },
             {
               "title": "Landscape Repairs",
               "sub_categories": [
                 {
                   "title": "Patio and Deck Repairs",
                   "styles": []
                 },
                 {
                   "title": "Garden Bed Repairs",
                   "styles": []
                 },
                 {
                   "title": "Pathway Repairs",
                   "styles": []
                 },
                 {
                   "title": "Retaining Wall Repairs",
                   "styles": []
                 },
                 {
                   "title": "Lawn Repairs",
                   "styles": []
                 },
                 {
                   "title": "Irrigation System Repairs",
                   "styles": []
                 },
                 {
                   "title": "Fence Repairs",
                   "styles": []
                 },
                 {
                   "title": "Drainage and Erosion Control",
                   "styles": []
                 }
               ]
             }
        ],
        "Craft & Hobbies": [
        {
              "title": "Scrapbooking",
              "sub_categories": [
                {
                  "title": "Memory Books",
                  "styles": []
                },
                {
                  "title": "Photo Albums",
                  "styles": []
                },
                {
                  "title": "Digital Scrapbooking",
                  "styles": []
                }
              ]
            },
            {
              "title": "Knitting and Crocheting",
              "sub_categories": [
                {
                  "title": "Blankets",
                  "styles": []
                },
                {
                  "title": "Clothing",
                  "styles": []
                },
                {
                  "title": "Accessories",
                  "styles": []
                }
              ]
            },
            {
              "title": "Jewelry Making",
              "sub_categories": [
                {
                  "title": "Beading",
                  "styles": []
                },
                {
                  "title": "Metalworking",
                  "styles": []
                },
                {
                  "title": "Resin Jewelry",
                  "styles": []
                }
              ]
            },
            {
              "title": "Holiday Arts and Crafts",
              "sub_categories": [
                {
                  "title": "Seasonal Decorations",
                  "styles": []
                },
                {
                  "title": "Ornaments",
                  "styles": []
                },
                {
                  "title": "Festive Crafts",
                  "styles": []
                }
              ]
            },
            {
              "title": "General Crafts",
              "sub_categories": [
                {
                  "title": "Paper Crafts",
                  "styles": []
                },
                {
                  "title": "Wood Crafts",
                  "styles": []
                },
                {
                  "title": "Painting and Drawing",
                  "styles": []
                },
                {
                  "title": "Craft Storage & Organization",
                  "styles": []
                }
              ]
            },
            {
              "title": "Kids Projects",
              "sub_categories": [
                {
                  "title": "Art Projects",
                  "styles": []
                },
                {
                  "title": "Toys",
                  "styles": []
                },
                {
                  "title": "Recycled Crafts",
                  "styles": []
                },
                {
                  "title": "Educational Projects",
                  "styles": []
                }
              ]
            }
        ],
        "Smart Home": [
          {
            "title": "Home Automation",
            "sub_categories": [
              {
                "title": "Smart Devices",
                "styles": []
              },
              {
                "title": "Voice Control",
                "styles": []
              },
              {
                "title": "Routine Setup",
                "styles": []
              }
            ]
          },
          {
            "title": "Security Systems",
            "sub_categories": [
              {
                "title": "Cameras",
                "styles": []
              },
              {
                "title": "Sensors",
                "styles": []
              },
              {
                "title": "Alarms",
                "styles": []
              }
            ]
          },
          {
                "title": "Home Automation",
                "sub_categories": [
                  {
                    "title": "Smart Devices",
                    "styles": []
                  },
                  {
                    "title": "Voice Control",
                    "styles": []
                  },
                  {
                    "title": "Routine Setup",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Security Systems",
                "sub_categories": [
                  {
                    "title": "Cameras",
                    "styles": []
                  },
                  {
                    "title": "Sensors",
                    "styles": []
                  },
                  {
                    "title": "Alarms",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Energy Efficiency",
                "sub_categories": [
                  {
                    "title": "Smart Thermostats",
                    "styles": []
                  },
                  {
                    "title": "Lighting Controls",
                    "styles": []
                  },
                  {
                    "title": "Solar Panels",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Entertainment",
                "sub_categories": [
                  {
                    "title": "Home Theaters",
                    "styles": []
                  },
                  {
                    "title": "Smart Speakers",
                    "styles": []
                  },
                  {
                    "title": "Gaming Setup",
                    "styles": []
                  }
                ]
              },
              {
                "title": "Lighting",
                "sub_categories": [
                  {
                    "title": "Smart Lighting",
                    "styles": []
                  }
                ]
              }
        ]
      }
    }
    styles = {
        'Living Room': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                        'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman',
                        'Asian', 'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Bedrooms': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                     'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                     'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Bathrooms': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                      'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                      'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Home Office': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                        'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman',
                        'Asian',
                        'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Basement': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                     'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                     'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Dining': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                   'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                   'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Loft': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                 'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                 'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Laundry': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                    'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                    'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Closet': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                   'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                   'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Kids Space': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                       'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman',
                       'Asian',
                       'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'College & Teen Space': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional',
                                 'Industrial', 'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern',
                                 'Tropical', 'Craftsman', 'Asian', 'Victorian', 'Mediterranean', 'French Country',
                                 'Shabby Chic'],
        'Home Gym': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional', 'Industrial',
                     'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern', 'Tropical', 'Craftsman', 'Asian',
                     'Victorian', 'Mediterranean', 'French Country', 'Shabby Chic'],
        'Patio & Gardening Decor': ['Contemporary', 'Traditional', 'Midcentury Modern', 'Farmhouse', 'Transitional',
                                    'Industrial', 'Scandinavian', 'Rustic', 'Coastal', 'Eclectic', 'Southwestern',
                                    'Tropical', 'Craftsman', 'Asian', 'Victorian', 'Mediterranean', 'French Country',
                                    'Shabby Chic']
    }

    for category, styles_list in styles.items():
        category_id = get_id_from_name(PROJECT_CATEGORY_URL, category)
        if not category_id:
            print(f"Category {category} not found. Skipping styles.")
            continue
        for style in styles_list:

            data = {'category': category_id, 'style': style}
            response = requests.post(PROJECT_STYLE_URL, json=data)
            if response.status_code == 201:
                print(f"Successfully posted style: {style} under category: {category}")
            else:
                print(
                    f"Failed to post style: {style} under category: {category}, Status code: {response.status_code}, Response: {response.text}")

def get_id_from_name(url, name):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()['data']
            for item in data:
                find_key = 'type'
                if url.endswith('categories/'):
                    find_key = 'category'
                if url.endswith('sub-categories/'):
                    find_key = 'sub_category'
                if item[find_key] == name:
                    return item['id']
        else:
            print(f"Failed to get data from {url}. Status Code: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error occurred while getting data: {e}")
        return None


if __name__ == "__main__":
    delete_existing_data()
    post_project_types()
    post_project_categories()
    post_project_sub_categories()
    post_project_styles()
