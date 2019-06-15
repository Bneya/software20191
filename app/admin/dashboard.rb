ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Navegación" do
          link_to "Volver al sitio", root_path
        end
      end
    end


    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Cantidad de publicaciones por curso" do
          ul do
            Course.all.each do |course|
              li course.name + " tiene " + course.posts.count.to_s + " publicaciones"
            end
          end
        end
      end

      column do
        panel "Cantidad de alumnos y ayudantes por curso" do
          ul do
            Course.all.each do |course|
              li course.name + " tiene " + Suscription.where(course_id: course.id, sbtype: "alumno").count.to_s + " alumnos y " + Suscription.where(course_id: course.id, sbtype: "teacher").count.to_s + " profesores"
            end
          end
        end
      end

      column do
        panel "Administradores del sitio" do
          ul do
            User.with_role(:admin).each do |user|
              li user.username
            end
          end
        end
      end
    end


  end # content
end
