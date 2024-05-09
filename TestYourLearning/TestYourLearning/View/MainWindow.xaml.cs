using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using TestYourLearning.Model;

namespace TestYourLearning.View
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private int idRole = 0;
        private int idHuman = 0;
        public MainWindow(int IdRole, int IdHuman)
        {
            InitializeComponent();

            idRole = IdRole;
            idHuman = IdHuman;

            using (TestDBEntities db = new TestDBEntities())
            {
                // Установка ФИО

                labelName.Content = db.Human.FirstOrDefault(u => u.Id == IdHuman).Surname + " " + db.Human.FirstOrDefault(u => u.Id == IdHuman).FirstName + "\n" +
                    db.Human.FirstOrDefault(u => u.Id == IdHuman).Patronymic;


                // Установка роли

                labelRole.Content = db.Role.FirstOrDefault(u => u.Id == IdRole).Name;


                // Установка группы/предмета

                if(IdRole == 1)
                {
                    labelSubject.Visibility = Visibility.Collapsed;
                    labelSubjectName.Visibility = Visibility.Collapsed;
                }
                else if(IdRole == 2)
                {
                    labelSubject.Visibility = Visibility.Visible;
                    labelSubjectName.Visibility = Visibility.Visible;

                    labelSubject.Content = "Предмет:";
                    int? humanSubject = db.Human.FirstOrDefault(u => u.Id == IdHuman).IdSubject;
                    labelSubjectName.Content = db.Subject.FirstOrDefault(u => u.Id == humanSubject).Name;
                }
                else
                {
                    labelSubject.Visibility = Visibility.Visible;
                    labelSubjectName.Visibility = Visibility.Visible;

                    labelSubject.Content = "Группа:";
                    int? humanGroup = db.Human.FirstOrDefault(u => u.Id == IdHuman).IdGroup;
                    int groupIndex = db.Group.FirstOrDefault(u => u.Id == humanGroup).IdIndex;
                    int groupName = db.Group.FirstOrDefault(u => u.Id == humanGroup).IdName;
                    labelSubjectName.Content = db.GroupName.FirstOrDefault(u => u.Id == groupName).Name + "-" + db.GroupIndex.FirstOrDefault(u => u.Id == groupIndex).Index;
                }


                // Установка Фото профиля

                int? userImage = db.User.FirstOrDefault(u => u.IdHuman == IdHuman).IdImage;
                int idImage = 0;
                idImage = db.ImageProfile.FirstOrDefault(u => u.Id == userImage).Id;

                foreach(var i in db.ImageProfile.ToList())
                {
                    if(i.Id == idImage)
                    {
                        try
                        {
                            imageProfile.Source = new BitmapImage(new Uri(db.ImageProfile.FirstOrDefault(u => u.Id == i.Id).Image));
                            if (i.Id != 1)
                            {
                                btnImageDelete.Visibility = Visibility.Visible;
                            }
                        }
                         catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message, "Ошибка");
                            imageProfile.Source = new BitmapImage(new Uri(db.ImageProfile.FirstOrDefault(u => u.Id == 1).Image));
                        }
                        
                    }
                }
            }
        }


        // Закрытие программы

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            App.Current.Shutdown();
        }


        // Выход

        private void Quit_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
        }


        // Изменение фото профиля

        private void btnImageChange_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog op = new OpenFileDialog();
            op.Title = "Select a picture";
            op.Filter = "All supported graphics|*.jpg;*.jpeg;*.png|" +
              "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|" +
              "Portable Network Graphic (*.png)|*.png";
            if (op.ShowDialog() == true)
            {
                using (TestDBEntities db = new TestDBEntities())
                {
                    var user = db.User.FirstOrDefault(u => u.IdHuman == idHuman);

                    int? userImage = db.User.FirstOrDefault(u => u.IdHuman == idHuman).IdImage;
                    int idImage = 0;

                    var imageProfileDb = db.ImageProfile.FirstOrDefault(u => u.Id == userImage);
                    idImage = db.ImageProfile.FirstOrDefault(u => u.Id == userImage).Id;

                    if (userImage != 1)
                    {
                        db.ImageProfile.Remove(imageProfileDb);
                        db.SaveChanges();
                    }

                    imageProfile.Source = new BitmapImage(new Uri(op.FileName));
                
                    imageProfileDb = new ImageProfile();
                    imageProfileDb.Image = op.FileName;
                    db.ImageProfile.Add(imageProfileDb);
                    db.SaveChanges();

                    int idNewImage = db.ImageProfile.OrderByDescending(x => x.Id).FirstOrDefault().Id;

                    user.IdImage = idNewImage;
                    db.User.AddOrUpdate(user);
                    db.SaveChanges();

                    btnImageDelete.Visibility = Visibility.Visible;
                }
            }
        }

        // Удаление фото профиля

        private void btnImageDelete_Click(object sender, RoutedEventArgs e)
        {
            using (TestDBEntities db = new TestDBEntities())
            {
                if (MessageBox.Show("Вы действительно хотите удалить фото профиля?", "Предупреждение", MessageBoxButton.YesNo, MessageBoxImage.Question) ==
                        MessageBoxResult.Yes)
                {
                    var user = db.User.FirstOrDefault(u => u.IdHuman == idHuman);

                    int? userImage = db.User.FirstOrDefault(u => u.IdHuman == idHuman).IdImage;
                    int idImage = 0;

                    var imageProfileDb = db.ImageProfile.FirstOrDefault(u => u.Id == userImage);
                    idImage = db.ImageProfile.FirstOrDefault(u => u.Id == userImage).Id;

                    if (userImage != 1)
                    {
                        imageProfile.Source = new BitmapImage(new Uri(db.ImageProfile.FirstOrDefault(u => u.Id == 1).Image));
                        user.IdImage = 1;
                        btnImageDelete.Visibility = Visibility.Collapsed;
                    }
                    db.User.AddOrUpdate(user);
                    db.SaveChanges();

                    db.ImageProfile.Remove(imageProfileDb);
                    db.SaveChanges();
                }
            }
        }
    }
}
