require "application_system_test_case"

class LessonsTest < ApplicationSystemTestCase
  setup do
    @lesson = lessons(:one)
  end

  test "visiting the index" do
    visit lessons_url
    assert_selector "h1", text: "Lessons"
  end

  test "should create lesson" do
    visit lessons_url
    click_on "New lesson"

    fill_in "Category", with: @lesson.category_id
    fill_in "Coach", with: @lesson.coach_id
    fill_in "Dia", with: @lesson.dia
    fill_in "Fin", with: @lesson.fin
    fill_in "Inicio", with: @lesson.inicio
    fill_in "Precio", with: @lesson.precio
    fill_in "Status", with: @lesson.status
    click_on "Create Lesson"

    assert_text "Lesson was successfully created"
    click_on "Back"
  end

  test "should update Lesson" do
    visit lesson_url(@lesson)
    click_on "Edit this lesson", match: :first

    fill_in "Category", with: @lesson.category_id
    fill_in "Coach", with: @lesson.coach_id
    fill_in "Dia", with: @lesson.dia
    fill_in "Fin", with: @lesson.fin
    fill_in "Inicio", with: @lesson.inicio
    fill_in "Precio", with: @lesson.precio
    fill_in "Status", with: @lesson.status
    click_on "Update Lesson"

    assert_text "Lesson was successfully updated"
    click_on "Back"
  end

  test "should destroy Lesson" do
    visit lesson_url(@lesson)
    click_on "Destroy this lesson", match: :first

    assert_text "Lesson was successfully destroyed"
  end
end
