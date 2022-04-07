// Variables
const userProfilePictures = document.querySelectorAll('.userProfilePicture');
const userPictureContent = document.querySelector('.picture');
const userPictureDiv =document.querySelector('.user-pictrue');
const btnCloseImg = document.querySelector('#btnCloseImage');
const btnCloseBackground = document.querySelector('.user-pictrue__background');

// Eventos

document.addEventListener('DOMContentLoaded', ()=> {
   loadEventListeners();
});

// Funciones

function loadEventListeners(){
    
    userProfilePictures.forEach( userProfilePicture => {
        userProfilePicture.addEventListener('click', maximizeImage)
    });
    
    btnCloseImg.addEventListener('click', closePictureDiv);
    btnCloseBackground.addEventListener('click', closePictureDiv);
}

function maximizeImage(e){
    userPictureDiv.classList.remove('no-display');
    const img = document.createElement('img');
    img.setAttribute('src', e.target.src);
    img.setAttribute('alt', "Foto de perfil de usuario");
    img.classList.add('user-pictrue__picture');
    userPictureContent.appendChild(img);    
}


function closePictureDiv(){
    userPictureDiv.classList.add('no-display');
    limpiarPictureDiv();
}

function limpiarPictureDiv(){
    
    while(userPictureContent.firstChild){
        userPictureContent.removeChild(userPictureContent.firstChild);
    }
    
}