using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Runtime.Remoting.Contexts;
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
            
            webview2.Source = new Uri(@"about:blank");

            dataGridSubject.ItemsSource = TestDBEntities.GetContext().Human.Where(u => u.IdSubject != null).ToList();

            dataGridStudents.ItemsSource = TestDBEntities.GetContext().User.Where(u => u.Human.IdGroup != null).ToList();
            dataGridTeachers.ItemsSource = TestDBEntities.GetContext().User.Where(u => u.Human.IdSubject != null).ToList();
            
            

            idRole = IdRole;
            idHuman = IdHuman;

            using (TestDBEntities db = new TestDBEntities())
            {
                dataGridScore.ItemsSource = TestDBEntities.GetContext().TestScore.Where(u => u.User.Human.IdGroup != null).ToList();

                // Установка ФИО

                labelName.Content = db.Human.FirstOrDefault(u => u.Id == IdHuman).Surname + " " + db.Human.FirstOrDefault(u => u.Id == IdHuman).FirstName + "\n" +
                    db.Human.FirstOrDefault(u => u.Id == IdHuman).Patronymic;


                // Установка роли

                labelRole.Content = db.Role.FirstOrDefault(u => u.Id == IdRole).Name;


                // Установка группы/предмета

                if(IdRole == 1)
                {
                    // оформление профиля
                    labelSubject.Visibility = Visibility.Collapsed;
                    labelSubjectName.Visibility = Visibility.Collapsed;
                }
                else if(IdRole == 2)
                {
                    // оформление профиля
                    labelSubject.Visibility = Visibility.Visible;
                    labelSubjectName.Visibility = Visibility.Visible;

                    labelSubject.Content = "Предмет:";
                    int? humanSubject = db.Human.FirstOrDefault(u => u.Id == IdHuman).IdSubject;
                    labelSubjectName.Content = db.Subject.FirstOrDefault(u => u.Id == humanSubject).Name;

                    teachersTabItem.Visibility = Visibility.Collapsed;

                    // скрытие списка предметов
                    subgectGrid.Visibility = Visibility.Collapsed;
                    lectureGrid.Visibility = Visibility.Visible;
                    humanBtn = TestDBEntities.GetContext().Human.FirstOrDefault(u => u.Id == idHuman);
                    nameSubject = humanBtn.Subject.Name;
                    idSubject = humanBtn.Subject.Id;
                    subjectNameLabel.Content = humanBtn.Subject.Name;
                    dataGridLecture.ItemsSource = TestDBEntities.GetContext().Lecture.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();
                    dataGridTests.ItemsSource = TestDBEntities.GetContext().Test.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();

                    // скрытие элементов
                    btnBackSubject.Visibility = Visibility.Collapsed;
                }
                else
                {
                    // оформление профиля
                    labelSubject.Visibility = Visibility.Visible;
                    labelSubjectName.Visibility = Visibility.Visible;

                    labelSubject.Content = "Группа:";
                    int? humanGroup = db.Human.FirstOrDefault(u => u.Id == IdHuman).IdGroup;
                    int groupIndex = db.Group.FirstOrDefault(u => u.Id == humanGroup).IdIndex;
                    int groupName = db.Group.FirstOrDefault(u => u.Id == humanGroup).IdName;
                    labelSubjectName.Content = db.GroupName.FirstOrDefault(u => u.Id == groupName).Name + "-" + db.GroupIndex.FirstOrDefault(u => u.Id == groupIndex).Index;

                    // скрытие элементов
                    teachersTabItem.Visibility = Visibility.Collapsed;
                    studentsTabItem.Visibility = Visibility.Collapsed;
                    btnAddLecture.Visibility = Visibility.Collapsed;
                    btnAddTest.Visibility = Visibility.Collapsed;
                    btnDeleteLectures.Visibility = Visibility.Collapsed;
                    btnUpdateLecture.Visibility = Visibility.Collapsed;
                    btnEditLectures.Visibility = Visibility.Collapsed;
                    btnUpdateSubject.Visibility = Visibility.Collapsed;
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

        private string nameSubject = "";
        private int idSubject = 0;
        private Human humanBtn = new Human();
        // Открытие спсика лекций с тестами
        private void btnOpenApp_Click(object sender, RoutedEventArgs e)
        {
            subgectGrid.Visibility = Visibility.Collapsed;
            lectureGrid.Visibility = Visibility.Visible;

            humanBtn = (sender as Button).DataContext as Human;

            nameSubject = humanBtn.Subject.Name;
            idSubject = humanBtn.Subject.Id;

            subjectNameLabel.Content = humanBtn.Subject.Name;

            dataGridLecture.ItemsSource = TestDBEntities.GetContext().Lecture.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();
            dataGridTests.ItemsSource = TestDBEntities.GetContext().Test.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();
        }

        // Возврат к предметам
        private void btnBackSubject_Click(object sender, RoutedEventArgs e)
        {
            subgectGrid.Visibility = Visibility.Visible;
            lectureGrid.Visibility = Visibility.Collapsed;
        }


        private Lecture lectureBtn = new Lecture();
        // Открытие лекции
        private void btnOpenLecture_Click(object sender, RoutedEventArgs e)
        {
            lectureGrid.Visibility = Visibility.Collapsed;
            lectureOpenGrid.Visibility = Visibility.Visible;

            lectureBtn = (sender as Button).DataContext as Lecture;
            try
            {
                webview2.CoreWebView2.Navigate(lectureBtn.Lecture1);
            }
            catch (Exception ex)
            {
                webview2.Source = new Uri(@"about:blank");
                MessageBox.Show("Введен неверный путь лекции", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }


        // Возврат к списку лекций
        private void btnBackLectures_Click(object sender, RoutedEventArgs e)
        {
            UpdateTestsAndLectures();
            lectureGrid.Visibility = Visibility.Visible;
            lectureOpenGrid.Visibility = Visibility.Collapsed;
        }

        // Открытие окна "Добавление лекций"
        private void btnAddLecture_Click(object sender, RoutedEventArgs e)
        {
            AddLectureWindow addLectureWindow = new AddLectureWindow(idSubject, null, true);
            addLectureWindow.ShowDialog();
        }

        // Обновление списка тестов и лекций
        private void btnUpdateSubject_Click(object sender, RoutedEventArgs e)
        {
            UpdateTestsAndLectures();
        }

        private void UpdateTestsAndLectures()
        {
            

            dataGridLecture.ItemsSource = null;
            dataGridTests.ItemsSource = null;

            using (TestDBEntities db = new TestDBEntities())
            {
                dataGridLecture.ItemsSource = db.Lecture.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();
            }
            dataGridTests.ItemsSource = TestDBEntities.GetContext().Test.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();
        }

        // Удаление лекции
        private void btnDeleteLectures_Click(object sender, RoutedEventArgs e)
        {
            using (TestDBEntities db = new TestDBEntities())
            {
                if (MessageBox.Show("Вы действительно хотите удалить лекцию?", "Предупреждение", MessageBoxButton.YesNo, MessageBoxImage.Question) ==
                        MessageBoxResult.Yes)
                {
                    var delLecture = db.Lecture.FirstOrDefault(u => u.Id == lectureBtn.Id);
                    db.Lecture.Remove(delLecture);
                    db.SaveChanges();

                    dataGridLecture.ItemsSource = TestDBEntities.GetContext().Lecture.Where(u => u.IdSubject == humanBtn.Subject.Id).ToList();

                    lectureGrid.Visibility = Visibility.Visible;
                    lectureOpenGrid.Visibility = Visibility.Collapsed;
                }
            }
        }

        // Редактирование лекции
        private void btnEditLectures_Click(object sender, RoutedEventArgs e)
        {

            AddLectureWindow addLectureWindow = new AddLectureWindow(idSubject, lectureBtn.Id, false);
            addLectureWindow.ShowDialog();
        }

        // Обновление лекции
        private void btnUpdateLecture_Click(object sender, RoutedEventArgs e)
        {
            using (TestDBEntities db = new TestDBEntities())
            {
                lectureBtn = db.Lecture.FirstOrDefault(u => u.Id == lectureBtn.Id);
                try
                {
                    webview2.CoreWebView2.Navigate(lectureBtn.Lecture1);
                }
                catch (Exception ex)
                {
                    webview2.Source = new Uri(@"about:blank");
                    MessageBox.Show("Введен неверный путь лекции", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        // Поиск по названию предмета
        private void searchSubjectBtn_Click(object sender, RoutedEventArgs e)
        {
            string searchSubject = searchSubjectTB.Text.ToLower();

            var subjects = TestDBEntities.GetContext().Human.Where(u => u.IdSubject != null).ToList();
            List<Human> newSubjects = subjects.Where(u => u.Subject.Name.ToLower().Contains(searchSubject)).ToList();

            dataGridSubject.ItemsSource = newSubjects;
        }

        // Обновление списка предметов
        private void btnNewUpdateSubject_Click(object sender, RoutedEventArgs e)
        {
            dataGridSubject.ItemsSource = TestDBEntities.GetContext().Human.Where(u => u.IdSubject != null).ToList();
        }

        // Поиск по фамилии студента
        private void searchStudentsBtn_Click(object sender, RoutedEventArgs e)
        {
            string searchSurname = searchStudentsTB.Text.ToLower();

            var students = TestDBEntities.GetContext().User.Where(u => u.Human.IdGroup != null).ToList();
            List<User> newStudents = students.Where(u => u.Human.Surname.ToLower().Contains(searchSurname)).ToList();

            dataGridStudents.ItemsSource = newStudents;
        }

        // Обновление списка студентов
        private void btnUpdateStudents_Click(object sender, RoutedEventArgs e)
        {
            dataGridStudents.ItemsSource = TestDBEntities.GetContext().User.Where(u => u.Human.IdGroup != null).ToList();
        }

        // Поиск по фамилии преподавателя
        private void searchTeachersBtn_Click(object sender, RoutedEventArgs e)
        {
            string searchSurname = searchTeachersTB.Text.ToLower();

            var teachers = TestDBEntities.GetContext().User.Where(u => u.Human.IdSubject != null).ToList();
            List<User> newTeachers = teachers.Where(u => u.Human.Surname.ToLower().Contains(searchSurname)).ToList();

            dataGridTeachers.ItemsSource = newTeachers;
        }

        // Обнволение спсика преподавателей
        private void btnUpdateTeachers_Click(object sender, RoutedEventArgs e)
        {
            dataGridTeachers.ItemsSource = TestDBEntities.GetContext().User.Where(u => u.Human.IdSubject != null).ToList();
        }

        // Добавление студента
        private void addStudentsBtn_Click(object sender, RoutedEventArgs e)
        {
            AddHumanWindow addHumanWindow = new AddHumanWindow(null, false);
            addHumanWindow.ShowDialog();
        }

        // Добавление преподавателя
        private void addTeachersBtn_Click(object sender, RoutedEventArgs e)
        {
            AddHumanWindow addHumanWindow = new AddHumanWindow(null, true);
            addHumanWindow.ShowDialog();
        }

        // Печать списка преподавателей
        private void printTeachersBtn_Click(object sender, RoutedEventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            PrintDialog printDialog = new PrintDialog();

            if (printDialog.ShowDialog() == true)
            {
                FlowDocument doc = new FlowDocument();

                using (var context = new TestDBEntities())
                {
                    var allItem = context.User.Where(u => u.Human.IdSubject != null).ToList();

                    foreach (var item in allItem)
                    {
                        Paragraph paragraph = new Paragraph();
                        var itemInfo = item;

                        if (itemInfo != null)
                        {
                            paragraph.Inlines.Add(new Run("Имя: " + itemInfo.Human.FirstName));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Фамилия: " + itemInfo.Human.Surname));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Отчество: " + itemInfo.Human.Patronymic));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Предмет: " + itemInfo.Human.Subject.Name));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Логин: " + itemInfo.Login));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Пароль: " + itemInfo.Password));
                        }
                        doc.Blocks.Add(paragraph);
                        doc.Blocks.Add(new BlockUIContainer(new Separator()));
                    }
                    printDialog.PrintDocument(((IDocumentPaginatorSource)doc).DocumentPaginator, "Печать всех элементов");
                }
            }
        }

        // Печать списка студентов
        private void printStudentsBtn_Click(object sender, RoutedEventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            PrintDialog printDialog = new PrintDialog();

            if (printDialog.ShowDialog() == true)
            {
                FlowDocument doc = new FlowDocument();

                using (var context = new TestDBEntities())
                {
                    var allItem = context.User.Where(u => u.Human.IdGroup != null).ToList();

                    foreach (var item in allItem)
                    {
                        Paragraph paragraph = new Paragraph();
                        var itemInfo = item;

                        if (itemInfo != null)
                        {
                            paragraph.Inlines.Add(new Run("Имя: " + itemInfo.Human.FirstName));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Фамилия: " + itemInfo.Human.Surname));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Отчество: " + itemInfo.Human.Patronymic));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Группа: " + itemInfo.Human.Group.GroupName.Name + " - " + itemInfo.Human.Group.GroupIndex.Index));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Логин: " + itemInfo.Login));
                            paragraph.Inlines.Add(new LineBreak());
                            paragraph.Inlines.Add(new Run("Пароль: " + itemInfo.Password));
                        }
                        doc.Blocks.Add(paragraph);
                        doc.Blocks.Add(new BlockUIContainer(new Separator()));
                    }
                    printDialog.PrintDocument(((IDocumentPaginatorSource)doc).DocumentPaginator, "Печать всех элементов");
                }
            }
        }
        List<TestScore> testScores;
        // Обновление журнала
        private void btnUpdateScore_Click(object sender, RoutedEventArgs e)
        {
            using (TestDBEntities db = new TestDBEntities())
            {
                testScores = db.TestScore.Include("User")
                                        .Include("User.Human")
                                        .Include("User.Human.Group")
                                        .Include("User.Human.Group.GroupName")
                                        .Include("User.Human.Group.GroupIndex")
                                        .Include("Test")
                                        .Include("Score")
                                        .Where(u => u.User.Human.IdGroup != null)
                                        .ToList();
            }

            dataGridScore.ItemsSource = testScores;
        }

        // Поиск оценок по фамилии студента
        private void searchScoreBtn_Click(object sender, RoutedEventArgs e)
        {
            string searchSurname = searchScoreTB.Text.ToLower();

            using (TestDBEntities db = new TestDBEntities())
            {
                testScores = db.TestScore.Include("User")
                                        .Include("User.Human")
                                        .Include("User.Human.Group")
                                        .Include("User.Human.Group.GroupName")
                                        .Include("User.Human.Group.GroupIndex")
                                        .Include("Test")
                                        .Include("Score")
                                        .Where(u => u.User.Human.IdGroup != null)
                                        .ToList();
            }

            dataGridScore.ItemsSource = testScores.Where(u => u.User.Human.Surname.ToLower().Contains(searchSurname) && u.User.Human.IdGroup != null).ToList(); 
        }

        // Добавление теста
        private void btnAddTest_Click(object sender, RoutedEventArgs e)
        {
            AddTestWindow addTestWindow = new AddTestWindow(idSubject);
            addTestWindow.ShowDialog();
        }

        // Открытие теста
        private void btnOpenTest_Click(object sender, RoutedEventArgs e)
        {
            var testBtn = (sender as Button).DataContext as Test;
            var idUser = TestDBEntities.GetContext().User.FirstOrDefault(u => u.IdHuman == idHuman).Id;

            OpenTestWindow openTestWindow = new OpenTestWindow(testBtn, idUser);
            openTestWindow.ShowDialog();
        }
    }
}
