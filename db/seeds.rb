cats = [
    {
    name: "Tom",
    age: 80,
    enjoys: "hunting",
    image: "https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png",
    },
    {
    name: "Damoclese",
    age: 12,
    enjoys: "pouncing on sleeping people",
    image: "https://c.pxhere.com/photos/62/da/cat_animal_pet_cat's_eyes_mieze_portrait_adidas_photo-1412570.jpg!d",
    },
    {
    name: "Snowball IV",
    age: 4,
    enjoys: "Quality music",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmVT6qhKcuCVnc5BfmjCYRS95xRqWurEnq0_g6pDURoAud2ugGsqiT9MNwksK1pHmd-Xk&usqp=CAU",
    },
]
cats.each do |cat|
    Cat.create cat
    puts "creating cat #{cat}"
end