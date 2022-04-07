// Variables
const userProfilePictures = document.querySelectorAll('.userProfilePicture');
const userPictureContent = document.querySelector('.picture');
const userPictureDiv =document.querySelector('.user-pictrue');
const btnCloseImg = document.querySelector('#btnCloseImage');
const btnCloseBackground = document.querySelector('.user-pictrue__background');
const body = document.querySelector('body');

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
    body.classList.add('no-show-scroll');
    moveScroll();
}


function closePictureDiv(){
    userPictureDiv.classList.add('no-display');
    body.classList.remove('no-show-scroll');
    limpiarPictureDiv();
}

function limpiarPictureDiv(){
    
    while(userPictureContent.firstChild){
        userPictureContent.removeChild(userPictureContent.firstChild);
    }
    
}

/* Variables that allow us to save the position of the scroll and change it */
let scrrollOntop;
let doc = document.documentElement;
function moveScroll(){
    scrrollOntop = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0);
    doc.scrollTop = scrrollOntop;
    userPictureDiv.style.top = `${scrrollOntop}px`;
}