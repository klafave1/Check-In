import UIKit

// View Controller responsible for managing the main user interface
class ViewController: UIViewController, CalendarViewDelegate {
    // MARK: - Properties
    private let calendarView = CalendarView()
    private var notesForDates: [Date: String] = [:]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Medication Management"
        view.backgroundColor = .white
        
        setupCalendarView()
    }
    
    // MARK: - Setup
    
    // Set up the calendar view
    private func setupCalendarView() {
        calendarView.delegate = self
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - CalendarViewDelegate
    
    // Function called when a date is selected on the calendar view
    func didSelectDate(_ date: Date) {
        // Present an alert controller for adding notes to the selected date
        let alertController = UIAlertController(title: "Add Notes", message: "Add notes for selected date", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter notes"
        }
        
        // Add action to save notes
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let notes = alertController.textFields?.first?.text else { return }
            self?.notesForDates[date] = notes
            self?.calendarView.reloadData()
            print("Notes for \(date): \(notes)")
        }
        
        // Add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
// Sources:
// https://developer.apple.com/documentation/uikit
//https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/
