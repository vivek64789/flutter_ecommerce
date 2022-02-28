const { Router } = require('express');
const { check } = require('express-validator');
const { createUsers } = require('../Controller/Register');
const { ValidatedAuth } = require('../Middlewares/ValidateAuth');
const { LoginUsuario, RenweToken } = require('../Controller/LoginController');
const { validateToken } = require('../Middlewares/ValidateToken');
const { changeFotoProfile, userPersonalRegister, getPersonalInformation, updateStreetAddress,uploadNewPicture } = require('../Controller/UserController');
const { uploadsProfile } = require('../Helpers/Multer');
const { uploadPicture } = require('../Helpers/uploadPictureMulter');
const { HomeCarouselSilder, ListCategoriesHome, ListProductsHome, ListCategoriesAll } = require('../Controller/HomeController');
const { addFavoriteProduct, productFavoriteForUser, saveOrderProducts, getPurchasedProducts, getProductsForCategories } = require('../Controller/ProductController');
const { AddhomeCarousel, addCategoryStatic, addProductsStatic, updateCategory,deleteProduct, updateProduct, deleteCategory, addCategory,getProduct, addProduct, getCategoryById } = require('../Controller/StaticDataController');

const router = Router();


router.post( '/api/register', [
    check('username', 'Username is required').not().isEmpty(),
    check('email', 'Email Address is required').isEmail(),
    check('passwordd', 'Password is required').not().isEmpty(),
    ValidatedAuth
], createUsers );


router.post('/api/login', [
    check('email', 'Email ID is required').isEmail(),
    check('passwordd', 'Password is required').not().isEmpty(),
    ValidatedAuth
], LoginUsuario );

router.put('/api/personal/register', validateToken, userPersonalRegister );
router.put('/api/update-street-address', validateToken, updateStreetAddress );


router.get('/api/get-personal-information', validateToken, getPersonalInformation);

router.get( '/api/login/renew', validateToken, RenweToken);

router.put('/api/update-image-profile', [validateToken, uploadsProfile.single('image')], changeFotoProfile);
router.post('/api/upload-picture', [validateToken, uploadPicture.single('picture')], uploadNewPicture);


// Router Home 
router.get('/api/home-carousel', validateToken, HomeCarouselSilder);
router.get('/api/list-categories', validateToken, ListCategoriesHome );
router.get('/api/list-products-home', validateToken, ListProductsHome);

// Router Categories
router.get('/api/list-categories-all', validateToken, ListCategoriesAll);

// Products
router.post('/api/add-Favorite-Product', validateToken, addFavoriteProduct );
router.get('/api/product-favorite-for-user', validateToken, productFavoriteForUser);
router.post('/api/save-order-products', validateToken, saveOrderProducts );
router.get('/api/get-purchased-products', validateToken, getPurchasedProducts );
router.get('/api/get-products-for-categories/:id', validateToken, getProductsForCategories );


// DATA STATIC - Home Carousel - Category - Products ---> MongoDB
router.get('/api/add-home-carousel' , AddhomeCarousel);
router.get('/api/add-category-static' , addCategoryStatic);
router.get('/api/category/:id' , getCategoryById);
router.post('/api/category' , addCategory);
router.put('/api/category' , updateCategory);
router.delete('/api/category' , deleteCategory);
router.get('/api/product' , getProduct);
router.post('/api/product' , addProduct);
router.delete('/api/product' , deleteProduct);
router.put('/api/product' , updateProduct);

module.exports = router ;    