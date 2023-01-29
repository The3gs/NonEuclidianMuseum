extends Node


class ArtObject:
    func _init(resource: Texture, dimensions: Vector2, title_text: String, creator: String, desc: String):
        image = resource
        size = dimensions
        title = title_text
        artist = creator
        description = desc
    var image: Texture
    var size: Vector2 #in millimeters
    var title: String
    var artist: String
    var description: String

var art_pieces = [
    ArtObject.new(
        preload("res://assets/art/1024px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project_(454045).jpg"),
        Vector2(0.325, 0.410), 
        "Self Portrait",
        "Vincent van Gogh", 
        "Oil on artist's board, mounted on cradled panel."
        ),
    ArtObject.new(
        preload("res://assets/art/1024px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg"),
        Vector2(0.92,0.73),
        "The Starry Night",
        "Vincent van Gogh",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Vincent_van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg"),
        Vector2(0.92,0.72),
        "Starry Night",
        "Vincent van Gogh",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Vincent_van_Gogh_-_Wheatfield_with_crows_-_Google_Art_Project.jpg"),
        Vector2(1.03,0.502),
        "Wheatfield with crows",
        "Vincent van Gogh",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-VanGogh-Irises_3.jpg"),
        Vector2(0.735,0.92),
        "Irises",
        "Vincent van Gogh",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/Roses_-_Vincent_van_Gogh.JPG"),
        Vector2(0.9,0.71),
        "Irises",
        "Vincent van Gogh",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Mona_Lisa,_by_Leonardo_da_Vinci,_from_C2RMF_retouched.jpg"),
        Vector2(0.53,0.77),
        "Portrait of Mona Lisa del Giocondo",
        "Leonardo da Vinci",
        "Oil on panel."
       ),
#    ArtObject.new(# I just dont enjoy that the only massive painting we got is also the only nude... Really sticks out.
#        preload("res://assets/art/1024px-Sandro_Botticelli_046.jpg"),
#        Vector2(2.785, 1.725),
#        "The Birth of Venus",
#        "Sandro Botticelli",
#        "Tempera on canvas."
#       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Botticelli_-_Adoration_of_the_Magi_(Zanobi_Altar)_-_Uffizi.jpg"),
        Vector2(1.34, 1.11),
        "Adoration of the Magi",
        "Sandro Botticelli",
        "Tempera on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Van_Eyck_-_Arnolfini_Portrait.jpg"),
        Vector2(0.595,0.82),
        "The Arnolfini Portrait",
        "Jan van Eyck",
        "Oil on panel."
       ),
    ArtObject.new(
        preload("res://assets/art/Annunciation_Triptych_(Merode_Altarpiece)_MET_DP273206.jpg"),
        Vector2(1.178,0.645),
        "Merode Altarpiece",
        "Robert Campin",
        "Oil on oak wood."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Claude_Monet_-_Woman_with_a_Parasol_-_Madame_Monet_and_Her_Son_-_Google_Art_Project.jpg"),
        Vector2(0.81,1.0),
        "Woman with a Parasol - Madame Monet and Her Son",
        "Claude Monet",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Claude_Monet_-_Seerosen.jpg"),
        Vector2(0.81,1.0),
        "Water Lilies",
        "Claude Monet",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/Johannes_Vermeer_(1632-1675)_-_The_Girl_With_The_Pearl_Earring_(1665).jpg"),
        Vector2(0.4,0.465),
        "The Girl With The Pearl Earring",
        "Johannes Vermeer",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Johannes_Vermeer_-_Het_melkmeisje_-_Google_Art_Project.jpg"),
        Vector2(0.41,0.455),
        "The Milkmaid",
        "Johannes Vermeer",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/Jan_Vermeer_-_The_Art_of_Painting_-_Google_Art_Project.jpg"),
        Vector2(1.0,1.2),
        "The Art of Painting",
        "Johannes Vermeer",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Edgar_Degas_-_Interior_-_Google_Art_Project.jpg"),
        Vector2(1.14376,0.81331),
        "Interior",
        "Edgar Degas",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Edgar_Germain_Hilaire_Degas_021.jpg"),
        Vector2(0.75,0.85),
        "The Dance Class",
        "Edgar Degas",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Edgar_Degas_-_Waiting_-_Google_Art_Project.jpg"),
        Vector2(0.610,0.483),
        "Waiting",
        "Edgar Degas",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/Edgar_Degas,_1867c_-_Ballerinas_in_Pink.jpg"),
        Vector2(0.74,0.59),
        "Dancers in Pink",
        "Edgar Degas",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Whistlers_Mother_high_res.jpg"),
        Vector2(1.624,1.443),
        "Whistler's Mother",
        "James McNeill Whistler",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-Whistler-Nocturne_in_black_and_gold.jpg"),
        Vector2(0.464,0.603),
        "Nocturne in Black and Gold: The Falling Rocket",
        "James McNeill Whistler",
        "Oil on canvas."
       ),
    ArtObject.new(
        preload("res://assets/art/1024px-James_McNeill_Whistler_-_Caprice_in_Purple_and_Gold-_The_Golden_Screen_-_Google_Art_Project.jpg"),
        Vector2(0.685,0.501),
        "Caprice in Purple and Gold: The Golden Screen",
        "James McNeill Whistler",
        "Oil on panel."
       ),
   ]

