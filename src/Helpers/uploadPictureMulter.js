const multer = require('multer');
const path = require('path');

var storage = multer.diskStorage({
    destination: ( req, res, cb ) => {
        cb(null, 'src/Uploads/Images')
    },
    filename: ( req, file, cb ) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname(file.originalname) )
    }
});


const uploadPicture = multer({ storage: storage });


module.exports = {
    uploadPicture
}