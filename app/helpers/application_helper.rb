module ApplicationHelper
  def feed_photo_or_generic(user)
    url = ""
    if ["zorro", "foxy", "juan ma", "juan manuel", "juan manuel salazar", "juan m"].include?(user)
      url = "mikeservices/zorro.jpg"
    elsif ["rascabel", "rasquitabel", "isabel h", "isa hincapie", "isa h", "isa hincapie"].include?(user)
      url = "mikeservices/isa_h.jpg"
    elsif ["mike", "ferrer", "migue f", "miguel ferrer", "mike el sobrio", "el etc", "maicol f", "migue ferrer", "mike services"].include?(user)
      url = "mikeservices/mike_f.jpg"
    elsif ["andy", "el coste", "andres", "coste", "andrés", "andrés sánchez", "andres sanchez", "el faraon"].include?(user)
      url = "mikeservices/andy.jpg"
    elsif ["chespo", "santiago g", "santi g", "santi chespo", "santiago chespo", "chespirito", "ches"].include?(user)
      url = "mikeservices/chespo.jpg"
    elsif ["londo", "londoño", "santiago londoño", "santi londo", "tetica", "santi l", "santiago l"].include?(user)
      url = "mikeservices/londo.jpg"
    elsif ["manuel", "manolo", "nolo", "nolo veo", "manu", "manel", "el capi"].include?(user)
      url = "mikeservices/manolo.jpg"
    elsif ["maria", "cake", "maria luisa", "maria l", "mariá", "maria luisa yepes"].include?(user)
      url = "mikeservices/maria.jpg"
    elsif ["cata", "cat", "catalina", "catamayo", "cata t", "cata tamayo", "catalina tamayo", "guarolina", "catana", "esperemos hasta mayo"].include?(user)
      url = "mikeservices/Cata.jpg"
    elsif ["juan da", "juan david", "juanchito", "juancho carrancho", "juancho", "chito", "juanchis", "juanda"].include?(user)
      url = "mikeservices/juanchito.jpg"
    elsif ["agus", "agus v", "agustin", "agustine", "agus vasquez"].include?(user)
      url = "mikeservices/agus.jpg"
    elsif ["isa m", "isabel muriel", "isa muriel", "novia agus", "misa", "muriel"].include?(user)
      url = "mikeservices/isabel_muriel.jpg"
    elsif ["maicol", "miguel j", "miguel jaramillo", "mike j", "maicol j", "maicol jaramillo", "maicol estres"].include?(user)
      url = "mikeservices/maicol.jpg"
    elsif ["majo", "majo aristizabal", "novia chespo", "majo aristi", "aristi", "maria jose", "maria j", "maria aristi"].include?(user)
      url = "mikeservices/majo.jpg"
    elsif ["pepe", "pepsi", "cami p", "camila pelaez", "camila", "peperoni", "pepi", "pepeligro", "pepebria", "cami pelaez"].include?(user)
      url = "mikeservices/pespsi.jpg"
    else
      return cl_image_tag "mikeservices/desco.jpg", height: 200, width: 200, crop: :fill, gravity: :face, class: "avatar-large"
    end
      return cl_image_tag url, height: 300, width: 300, crop: :fill,gravity: :face, class: "avatar-large"
  end
end
