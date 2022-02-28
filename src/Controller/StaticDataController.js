const homeCarousel = require('../Models/home_carouse');
const Category = require('../Models/category');
const Products = require('../Models/Products');
const { body } = require('express-validator');

const AddhomeCarousel = async (req, res) => {

    await homeCarousel.insertMany([
        {
            "image": "home-hogar-slide-1.jpg",
            "category": "hogar"
        },
        {
            "image": "home-games-slide-2.jpg",
            "category": "Games"
        },
        {
            "image": "home-ropa-slide-3.jpg",
            "category": "Ropa"
        },
        {
            "image": "home-tec-slide-4.jpg",
            "category": "Tec"
        },
        {
            "image": "home-entrena-slide-5.jpg",
            "category": "Fitness"
        },
        {
            "image": "home-tecnologia-slide-6.jpg",
            "category": "Tecnologies"
        },
        {
            "image": "home-free-slide-7.jpg",
            "category": "Delivery Free"
        }
    ]);

    res.json({
        resp: true
    });
}


const addCategoryStatic = async (req, res) => {

    await Category.insertMany([
        {
            "category": "home",
            "picture": "hogar-categories.svg"
        },
        {
            "category": "Computing",
            "picture": "ordenador-portatil.svg"
        },
        {
            "category": "Home Appliances",
            "picture": "electrodomestico.svg"
        },
        {
            "category": "Sport and Fitness",
            "picture": "fitness.svg"
        },
        {
            "category": "Toys",
            "picture": "juguetes.svg"
        },
        {
            "category": "Belleza y Cuidado",
            "picture": "belleza.svg"
        },
        {
            "category": "Accesorios Vehiculo",
            "picture": "coche.svg"
        },
        {
            "category": "Cell Phones",
            "picture": "smartphone.svg"
        },
        {
            "category": "Audio y Video",
            "picture": "microfono.svg"
        },
        {
            "category": "Clothing",
            "picture": "camiseta.svg"
        },
        {
            "category": "Autos, Motos",
            "picture": "autos-motos.svg"
        },
        {
            "category": "Jewels",
            "picture": "joyas.svg"
        },
        {
            "category": "Console and video games",
            "picture": "videojuegos.svg"
        },
        {
            "category": "Pets",
            "picture": "animales.svg"
        },
        {
            "category": "Camara",
            "picture": "camaras.svg"
        },
        {
            "category": "Oficinas",
            "picture": "oficinas.svg"
        },
        {
            "category": "Music and Movies",
            "picture": "musica-pelicula.svg"
        },
        {
            "category": "Health",
            "picture": "salud.svg"
        },
        {
            "category": "Babies",
            "picture": "bebes.svg"
        },
        {
            "category": "Tools",
            "picture": "herramientas.svg"
        },
        {
            "category": "Books and Papers",
            "picture": "libros.svg"
        },
        {
            "category": "Services",
            "picture": "servicios.svg"
        },
        {
            "category": "Regards",
            "picture": "recuerdos.svg"
        },
        {
            "category": "Electronics",
            "picture": "electronica.svg"
        },
        {
            "category": "Others",
            "picture": "otros-app.svg"
        }
    ]);

    res.json({
        resp: true,
        msj: 'Data inserted correctly - Category'
    });

}
const addCategory = async (req, res) => {
    const { category, picture } = req.body;
    var createdCategory = await Category.create(
        {
            "category": category,
            "picture": picture
        }
    );
    createdCategory.save();

    res.json({
        resp: true,
        msj: 'Category inserted Successfully'
    });

}
const updateCategory = async (req, res) => {
    console.log(body);
    const { id, category, picture } = req.body;

    const data = {
        category: category,
        picture: picture
    }
    console.log(data);

    var result = await Category.findByIdAndUpdate(id, data)
    if (result?.status) {
        res.json({
            resp: true,
            msj: 'Category updated Successfully'
        });
    }
    else {
        res.json({
            resp: false,
            msj: 'There is some error updating category'
        });
    }


}
const deleteCategory = async (req, res) => {
    const { id } = req.body;
    var result = await Category.findByIdAndDelete(id);
    console.log("This is result of delete category", result);
    if (result?.status) {
        res.json({
            resp: true,
            msj: 'Category deleted Successfully'
        });
    }
    else {
        res.json({
            resp: false,
            msj: 'There is some error'
        });
    }
}
const deleteProduct = async (req, res) => {
    try {
        const { id } = req.body;
        var result = await Products.findByIdAndDelete(id);
        if (result?.status) {
            res.json({
                resp: true,
                msj: 'Product deleted Successfully'
            });
        }
        else {
            res.json({
                resp: false,
                msj: 'There is some error'
            });
        }
    } catch (error) {
        res.json({
            resp: false,
            msj: 'There is some error'
        });
    }
}

const getCategoryById = async (req, res) => {
    var category = await Category.findById(req.params.id);
    console.log("This is data of fetched category", category);
    if (category?.status) {
        res.json({
            resp: true,
            msj: 'Category Fetched Successfully'
        });
    }
    else {
        res.json({
            resp: false,
            msj: 'There is some error',
            category: category
        });
    }
}


const addProductsStatic = async (req, res) => {

    await Products.insertMany([
        {
            "nameProduct": "Apple iPhone 11 Pro 64 Gb",
            "description": "EQUIPOS NUEVOS, LIBRES DE FABRICA CON BOLETA DE VENTA. ¡SE BRINDA 12 MESES DE GARANTIA!!!!!",
            "codeProduct": "0000001",
            "stock": 15,
            "price": 4890.90,
            "status": "Active",
            "picture": "Apple-iPhone-11-Pro-64-Gb.jpg",
            "category_id": "621b890efd905ed9d4b073a8"
        },
    ]);

    res.json({
        resp: true,
        msj: 'Data inserted correctly - Products'
    });

}

const addProduct = async (req, res) => {
    try {
        const { status, nameProduct, description, codeProduct, stock, price, picture, category_id } = req.body;
        var createdProduct = await Products.create(
            {
                "nameProduct": nameProduct,
                "description": description,
                "codeProduct": codeProduct,
                "stock": stock,
                "price": price,
                "status": status,
                "picture": picture,
                "category_id": category_id
            }
        );

        createdProduct.save();

        res.json({
            resp: true,
            msj: 'Product added successfully'
        });
    } catch (error) {
        res.json({
            resp: false,
            msj: 'There is some error'
        });
    }

}


const updateProduct = async (req, res) => {
    try {
        const { id, status, nameProduct, description, codeProduct, stock, price, picture, category_id } = req.body;

        const data = {
            "nameProduct": nameProduct,
            "description": description,
            "codeProduct": codeProduct,
            "stock": stock,
            "price": price,
            "status": status,
            "picture": picture,
            "category_id": category_id
        }


        var result = await Products.findByIdAndUpdate(id, data)
        if (result?.status) {
            res.json({
                resp: true,
                msj: 'Product updated Successfully'
            });
        }
        else {
            res.json({
                resp: false,
                msj: 'There is some error updating Product'
            });
        }
    } catch (error) {
        res.json({
            resp: false,
            msj: 'There is some error'
        });
    }

}


const getProduct = async (req, res) => {
    try {
        console.log("I am in product");

        res.json({
            resp: true,
            msj: 'Product added successfully'
        });
    } catch (error) {
        res.json({
            resp: false,
            msj: 'There is some error'
        });
    }

}


module.exports = {
    AddhomeCarousel,
    addCategoryStatic,
    addProductsStatic,
    addCategory,
    addProduct,
    updateCategory,
    deleteCategory,
    getCategoryById,
    getProduct,
    deleteProduct,
    updateProduct
}