import UIKit

// Delegating date selection
protocol CalendarViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

// Custom calendar view
class CalendarView: UIView {
    // MARK: - Properties
    private let calendar = Calendar.current
    private var currentDate: Date = Date()
    private var collectionView: UICollectionView!
    private var notesForDates: [Date: String] = [:]
    private var headerLabel: UILabel!
    
    // Delegate for handling date selection
    weak var delegate: CalendarViewDelegate?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupNavigationButtons()
        updateHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    // Set up collection view
    private func setupCollectionView() {
        // Configure collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // Set up header label
        headerLabel = UILabel()
        headerLabel.textAlignment = .center
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Initialize collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        
        // Add collection view to the view hierarchy
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Set up navigation buttons
    private func setupNavigationButtons() {
        let prevButton = UIButton(type: .system)
        prevButton.setTitle("<", for: .normal)
        prevButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(">", for: .normal)
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, nextButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: headerLabel.heightAnchor)
        ])
    }
    
    // MARK: - Button Actions
    
    // Go to the previous month
    @objc private func previousMonth() {
        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
        updateHeader()
        reloadData()
    }
    
    // Go to the next month
    @objc private func nextMonth() {
        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
        updateHeader()
        reloadData()
    }
    
    // Update header label with current month and year
    private func updateHeader() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let monthYearString = dateFormatter.string(from: currentDate)
        headerLabel.text = monthYearString
    }
    
    // Reload collection view data
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Collection View Data Source and Delegate Methods

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Number of days in the current month
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return 0 }
        return range.count
    }
    
    // Create cell for each day in the current month
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let date = calendar.date(byAdding: .day, value: indexPath.item, to: firstDayOfMonth)!
        cell.textLabel.text = "\(calendar.component(.day, from: date))"
        // Highlight cell if it has notes
        let hasNotes = notesForDates[date] != nil
        cell.backgroundColor = hasNotes ? .yellow : .white
        return cell
    }
    
    // Set cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }
    
    // Handle selection of date
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let date = calendar.date(byAdding: .day, value: indexPath.item, to: firstDayOfMonth)!
        delegate?.didSelectDate(date)
    }
}

// Calendar cell
class CalendarCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up cell views
    private func setupViews() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// Sources:
// https://developer.apple.com/documentation/uikit
//https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/
// https://developer.apple.com/documentation/uikit/uicollectionview
